//
//  SkillChoiceView.swift
//  AutoInsight
//
//  Created by Quercy on 03.08.2024.
//

import SwiftUI

struct SkillChoiceView: View {
    @State private var isBeginner = false
    @State private var isExpert = false
    
    @Environment(\.locale) var locale
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Beginner Section
            NavigationStack {
                Button(action: {
                    withAnimation {
                        isBeginner = true
                    }
                }) {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        Text("I'm a Beginner")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .sensoryFeedback(.success, trigger: isBeginner)
                }
                
                
            }
            .navigationDestination(isPresented: $isBeginner) {
                QuizForCarsView()
                    .environment(\.locale, locale)
            }
            
            // Expert Section
            NavigationStack {
                Button(action: {
                    withAnimation {
                        isExpert = true
                    }
                }) {
                    HStack {
                        Image(systemName: "person.bust.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                        Text("I'm an Expert")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.yellow)
                    .sensoryFeedback(.success, trigger: isExpert)
                }
            }
            .navigationDestination(isPresented: $isExpert) {
                CategoriesView()
                    .environment(\.locale, locale)
            }
            
        }
    }
}

#Preview {
    SkillChoiceView()
}

