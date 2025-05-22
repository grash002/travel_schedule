//
//  UserAgreementView.swift
//  travel_schedule
//
//  Created by Иван Иван on 21.05.2025.
//

import SwiftUI

struct UserAgreementView: View {
    @Binding var path: NavigationPath
    
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

#Preview {
    UserAgreementView(path: .constant(NavigationPath()))
}
