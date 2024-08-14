//
//  GradientView.swift
//  AutoInsight
//
//  Created by Quercy on 11.07.2024.
//

import SwiftUI

struct GradientView: View {
    var text: String
    var gradient: Gradient
    @State private var isTapped = false
    
    var body: some View {
        Text(text)
            .font(isTapped ? .system(size: 50) : .largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.clear) // Make text color clear to show gradient
            .background(
                LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
                    .mask(
                        Text(text)
                            .font(isTapped ? .system(size: 50) : .largeTitle)
                            .fontWeight(.bold)
                    )
            )
            .onTapGesture {
                withAnimation {
                    isTapped.toggle()
                }
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
    }
}

#Preview {
    GradientView(text: "Hello internet", gradient: Gradient(colors: [.green, .blue]))
}
