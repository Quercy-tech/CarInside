//
//  ChatGPTModel.swift
//  AutoInsight
//
//  Created by Quercy on 23.07.2024.
//
import Foundation
import OpenAI

class ChatController: ObservableObject {
    @Published var displayedMessages: [Message] = []
    var messages: [Message] = []
    
    let openAI = OpenAI(apiToken: "sk-None-MjKISt8WZARD4Fr4qdmyT3BlbkFJEUJs1amvPKuiwHBwn7c0")
    
    let initialSetupMessage = Message(content: "You are a friendly and knowledgeable car mechanic. Provide detailed and helpful answers to car-related questions. Your name is Bovdyr.", isUser: false)
    
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
            model: .gpt3_5Turbo
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




