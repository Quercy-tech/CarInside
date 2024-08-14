//
//  Header.swift
//  AutoInsight
//
//  Created by Quercy on 17.07.2024.
//

import SwiftUI

struct Header: View {
    var text: LocalizedStringResource
    var subtext: LocalizedStringResource
    
    @State private var isTapped = false

    var body: some View {
        VStack {
            GradientView(text: "CarInside", gradient: Gradient(colors: [.green, .blue]))
                .padding(.vertical)
            Text(text)
                .font(isTapped ? .system(size: 50) : .largeTitle)
                .fontWeight(.bold)
                .onTapGesture {
                    withAnimation {
                        isTapped.toggle()
                    }
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                }
            Text(subtext )
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    Header(text: "Car companies", subtext: "Swipe down to close the menu")
}
