//
//  NoCarFoundView.swift
//  AutoInsight
//
//  Created by Quercy on 18.07.2024.
//

import SwiftUI

struct NoCarFoundView: View {
    @State private var isTapped = false
        
        var body: some View {
            VStack {
                Header(text: "No car found😞", subtext: "Try to change some parameters")
                
                Image(systemName: "car.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: isTapped ? 100 : 65)
                    .foregroundColor(.primary)
                    .padding()
                    .animation(.smooth(duration: 0.2), value: isTapped)
                    .onTapGesture {
                        isTapped.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            isTapped.toggle()
                        }
                    }
                
                
            }
        }
    }

#Preview {
    NoCarFoundView()
}
