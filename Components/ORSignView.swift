//
//  ORSignView.swift
//  AutoInsight
//
//  Created by Quercy on 04.08.2024.
//

import SwiftUI

struct ORSignView: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 90)
                    .foregroundColor(.black)
                Text("OR")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .offset(y: 20)
            Spacer()
        }
    }
}

#Preview {
    ORSignView()
}
