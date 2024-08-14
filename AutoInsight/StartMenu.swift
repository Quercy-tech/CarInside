//
//  StartMenu.swift
//  AutoInsight
//
//  Created by Quercy on 10.07.2024.
//

import SwiftUI

struct StartMenu: View {
    @State private var showCars = false
    @State private var showLanguageSelection = false
    @State private var locale: Locale = Locale(identifier: UserDefaults.standard.string(forKey: "appLanguage") ?? "en")

    
    @State private var reload = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let isCompact = geometry.size.width < 600
                
                VStack(spacing: isCompact ? 15 : 25) {
                    Header(text: "Find an ideal car", subtext: "Thousands of cars at your fingertips")
                        .padding(.top, isCompact ? 20 : 40)

                    ScrollView(.vertical, showsIndicators: false) {                            VStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(1...6, id: \.self) { car in
                                            Image("\(car) Small")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: isCompact ? 100 : geometry.size.width / 5, height: isCompact ? 70 : geometry.size.height / 6)
                                                .clipped()
                                                .cornerRadius(10)
                                        }
                                    }
                                    .padding([.leading, .trailing])
                                }

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(7...12, id: \.self) { car in
                                            Image("\(car) Small")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: isCompact ? 100 : geometry.size.width / 5, height: isCompact ? 70 : geometry.size.height / 6)
                                                .clipped()
                                                .cornerRadius(10)
                                        }
                                    }
                                    .padding([.leading, .trailing])
                                }
                                
                            }
                            // Explore Cars Section
                            VStack(spacing: 10) {
                                Text("Find cars for any occasion")
                                    .font(isCompact ? .title3 : .title2)
                                    .bold()

                                Text("Browse an incredible selection of cars, from the everyday to the extraordinary.")
                                    .multilineTextAlignment(.center)
                                    .padding([.leading, .trailing], isCompact ? 10 : 20)
                                
                                
                            }
                            
                            NavigationLink(destination: SkillChoiceView()
                                .environment(\.locale, locale)
                            ) {
                                Text("Explore cars")
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: isCompact ? 180 : geometry.size.width / 2, height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .padding()
                            }
                            .zIndex(1)

                            // Help Section
                            VStack(alignment: .leading, spacing: 10) {
                                
                                
                                Image("Hills2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: isCompact ? 200 : 300)
                                    .clipped()
                                    .overlay(
                                        Text("Need help with cars?")
                                            .font(isCompact ? .title : .largeTitle)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.black.opacity(0.75))
                                            .cornerRadius(10)
                                            .padding([.top, .leading], 16),
                                        alignment: .topLeading
                                    )

                                Text("Using ChatGPT")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                    .padding([.leading, .trailing, .top], 16)

                                Text("Use AI help for your needs")
                                    .font(isCompact ? .title2 : .title)
                                    .fontWeight(.bold)
                                    .padding([.leading, .trailing, .bottom], 16)

                                NavigationLink(destination: ChatGPTView()
                                    .environment(\.locale, locale)
                                ) {
                                    Text("Click here")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                        .padding([.leading, .trailing, .bottom], 16)
                                }
                                
                                
                                
                            }
                            .frame(maxWidth: geometry.size.width * 0.9)
                    }

                    // Change language of app
                    Button(action: {
                        showLanguageSelection = true
                    }) {
                        Text("Change Language")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: isCompact ? 180 : geometry.size.width / 2, height: isCompact ? 50 : geometry.size.height / 15)
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.bottom, 7)
                    }
                    .sheet(isPresented: $showLanguageSelection) {
                        LanguagesView(selectedLocale: $locale)
                            .environment(\.locale, locale)
                    }
                    .navigationDestination(isPresented: $reload, destination: {
                        StartMenu()
                            .environment(\.locale, locale)
                    })
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, isCompact ? 15 : 20)
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    setLocale()
                }
            }
        }
        .environment(\.locale, locale)
    }

    private func setLocale() {
        if let savedLocale = UserDefaults.standard.string(forKey: "appLanguage") {
            locale = Locale(identifier: savedLocale)
        }
    }
}

#Preview("English") {
    StartMenu()
}

#Preview("Ukrainian") {
    StartMenu()
        .environment(\.locale, Locale(identifier: "uk"))
}

#Preview("Russian") {
    StartMenu()
        .environment(\.locale, Locale(identifier: "ru"))
}
