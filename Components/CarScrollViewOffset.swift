//
//  CarScrollViewOffset.swift
//  AutoInsight
//
//  Created by Quercy on 11.07.2024.
//

import SwiftUI

struct CarScrollViewOffset: View {
    let quantityOfCars:Int = 12
    
    var body: some View {
        GeometryReader { geometry in
        HStack(spacing: 10) {
                let isCompact = geometry.size.width < 600
                ForEach((quantityOfCars / 2 + 1)..<quantityOfCars, id: \.self) { car in
                    Image("\(car) Small")
                        .resizable()
                        .scaledToFill()
                        .frame(width: isCompact ? 100 : geometry.size.width / 5, height: isCompact ? 70 : geometry.size.height / 10)
                        .clipped()
                        .cornerRadius(10)
                }
                
            }
            .padding([.leading, .trailing])
        }
    }
}

#Preview {
    CarScrollViewOffset()
}
