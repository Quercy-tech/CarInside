//
//  GPT-HelpView.swift
//  AutoInsight
//
//  Created by Quercy on 19.07.2024.
//

import SwiftUI

struct ChatGPTView: View {
    @StateObject var chatController = ChatController()
    @State private var input: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            Header(text: "Chat with specialist", subtext: "Chat uses specialised ChatGPT 3.5 turbo. To copy text, long press on the bubble")
            
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(chatController.displayedMessages) { message in
                        MessageView(message: message)
                            .padding(5)
                    }
                }
                .onChange(of: chatController.displayedMessages.count) {
                if let lastMessage = chatController.displayedMessages.last {
                        withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                        }
                                    }
                                }
            }
            Divider()
            HStack {
                TextField("Message...", text: $input, axis: .vertical)
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .focused($isFocused)
                Button {
                    chatController.sendNewMessage(content: input)
                    input = ""
                    isFocused = false
                } label: {
                    Image(systemName: "paperplane.fill")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatGPTView()
}


