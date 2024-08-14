//
//  GlowingText.swift
//  AutoInsight
//
//  Created by Quercy on 29.07.2024.
//

import SwiftUI

struct GlowingTextView: View {
    var text: String
    var body: some View {
            let gradient = LinearGradient(
                gradient: Gradient(colors: [.green, .blue]),
                startPoint: .leading,
                endPoint: .trailing
            )
            
            return Text(text)
                .font(.largeTitle)
                .foregroundColor(.white)
                .overlay(
                    Text(text)
                        .font(.largeTitle)
                        .foregroundStyle(gradient)
                        .blur(radius: 5)
                )
                .overlay(
                    Text(text)
                        .font(.largeTitle)
                        .foregroundStyle(gradient)
                        .blur(radius: 10)
                )
                .overlay(
                    Text(text)
                        .font(.largeTitle)
                        .foregroundStyle(gradient)
                )
        }
}

#Preview {
    GlowingTextView(text: "CarInsight")
}
