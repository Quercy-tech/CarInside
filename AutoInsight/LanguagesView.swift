//
//  LanguagesView.swift
//  AutoInsight
//
//  Created by Quercy on 09.08.2024.
//

import SwiftUI


struct LanguagesView: View {
    @Binding var selectedLocale: Locale
    @Environment(\.dismiss) var dismiss
    
    let availableLanguages = [
        ("English 🇬🇧", "en"),
        ("Українська 🇺🇦", "uk"),
        ("Русский", "ru")
    ]
    
    var body: some View {
        SwipeDownText()
        
        Header(text: "Select Language", subtext: "Choose what language would you like to use in this app")
        List(availableLanguages, id: \.1) { language in
            Button(action: {
                selectedLocale = Locale(identifier: language.1)
                saveLocale(language.1)
                dismiss()
            }) {
                Text(language.0)
                    .foregroundColor(selectedLocale.identifier == language.1 ? .blue : .primary)
            }
        }
        .navigationBarItems(trailing: Button("Close") {
            dismiss()
        })
    }
    private func saveLocale(_ identifier: String) {
        UserDefaults.standard.set(identifier, forKey: "appLanguage")
    }
}

#Preview {
    LanguagesView(selectedLocale: .constant(Locale(identifier: "en")))
}
