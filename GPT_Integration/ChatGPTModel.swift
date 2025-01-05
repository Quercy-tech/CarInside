//
//  ChatGPTModel.swift
//  AutoInsight
//
//  Created by Quercy on 23.07.2024.
//
import Foundation
import OpenAI

func loadAPIKey() -> String? {
    guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return nil }
    guard let mySecretApiKey: String = infoDictionary["OPENAI_API_TOKEN"] as? String else { return nil }
    print("Here's your api key value -> \(mySecretApiKey)")
    return mySecretApiKey
}


class ChatController: ObservableObject {
    @Published var displayedMessages: [Message] = []
    var messages: [Message] = []
    let openAI = OpenAI(apiToken: loadAPIKey()!)
 
    let initialSetupMessage = Message(content: "You are a friendly and knowledgeable car mechanic. Provide detailed and helpful answers to car-related questions. Your name is Mechanicus Maximus.", isUser: false)
    
    init() {
        
        self.messages.append(initialSetupMessage)
    }
    
    func sendNewMessage(content: String) {
        let userMessage = Message(content: content, isUser: true)
        self.messages.append(userMessage)
        self.displayedMessages.append(userMessage)
        getBotReply()
    }
    
    func getBotReply() {
        var allMessages = [initialSetupMessage]
        allMessages.append(contentsOf: self.messages)
        
        let query = ChatQuery(
            messages: allMessages.map({.init(role: $0.isUser ? .user : .system, content: $0.content)!}),
            model: .gpt4_o
        )
        
        openAI.chatsStream(query: query) { result in
            switch result {
            case .success(let success):
                self.handleStreamingResponse(success)
            case .failure(let failure):
                print("Streaming Error: \(failure)")
            }
        } completion: { error in
            print(error?.localizedDescription ?? "")
        }
    }
    
    private func handleStreamingResponse(_ success: ChatStreamResult) {
        guard let choice = success.choices.first else { return }
        let content = choice.delta.content ?? ""
        
        DispatchQueue.main.async {
            if !content.isEmpty {
                let botMessage = Message(content: content, isUser: false)
                if self.displayedMessages.last?.isUser == false {
                    self.displayedMessages[self.displayedMessages.count - 1].content += content
                } else {
                    self.displayedMessages.append(botMessage)
                }
            }
        }
    }
}


struct Message: Identifiable, Equatable {
    var id: UUID = .init()
    var content: String
    var isUser: Bool
}




