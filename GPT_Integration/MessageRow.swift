//
//  MessageRow.swift
//  AutoInsight
//
//  Created by Quercy on 23.07.2024.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    var body: some View {
        Group {
            if message.isUser {
                HStack {
                    Spacer()
                    Text(message.content)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .textSelection(.enabled)
                }
            } else {
                HStack {
                    Text(message.content)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .textSelection(.enabled)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MessageView(message: Message(content: "Hello is it AI?", isUser: true))
}

