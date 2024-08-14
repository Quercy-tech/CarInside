//
//  BackButton.swift
//  AutoInsight
//
//  Created by Quercy on 22.07.2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Back")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 5)
            .transition(.slide)
        }
    }
}


#Preview {
    BackButton()
}
