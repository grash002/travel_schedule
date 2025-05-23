//
//  UserAgreementView.swift
//  travel_schedule
//
//  Created by Иван Иван on 21.05.2025.
//

import SwiftUI

// MARK: - UserAgreementView

struct UserAgreementView: View {
    
    // MARK: - Properties
    
    @Binding var path: NavigationPath
    
    // MARK: - Views
    
    var body: some View {
        Group {
            if let url = URL(string: "https://yandex.ru/legal/practicum_offer/") {
                WebView(url: url)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    path.removeLast()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                        .imageScale(.large)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    UserAgreementView(path: .constant(NavigationPath()))
}
