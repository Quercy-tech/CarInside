//
//  SwipeDownText.swift
//  AutoInsight
//
//  Created by Quercy on 08.08.2024.
//

import SwiftUI

struct SwipeDownText: View {
    var body: some View {
        VStack {
            Image(systemName: "arrow.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text("Swipe Down")
                .font(.system(size: 18))
        }
    }
}

#Preview {
    SwipeDownText()
}
