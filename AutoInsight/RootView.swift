//
//  RootView.swift
//  AutoInsight
//
//  Created by Quercy on 28.07.2024.
//

import SwiftUI

struct RootView: View {
    @State private var showSplash = true
    var body: some View {
        Group {
            if showSplash {
                SplashScreenView()
            } else {
                StartMenu()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    RootView()
}
