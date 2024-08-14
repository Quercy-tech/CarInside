//
//  LoadingScreenView.swift
//  AutoInsight
//
//  Created by Quercy on 29.07.2024.
//

import SwiftUI

struct LoadingScreenView: View {
    private let images = ["RedWheel", "OrangeWheel", "YellowWheel", "LightBlueWheel", "BlueWheel"]
        @State private var currentIndex = 0
        @State private var rotation: Double = 0

        private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            
                Image(images[currentIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(rotation))
                    .onReceive(timer) { _ in
                        withAnimation(.linear(duration: 0.5)) {
                            rotation += 45  // Adjust the rotation angle as needed
                        }
                        currentIndex = (currentIndex + 1) % images.count
                    }
                    .frame(width: 100, height: 100)
            }
    }
}

#Preview {
    LoadingScreenView()
}
