//
//  AppSettings.swift
//  travel_schedule
//
//  Created by Иван Иван on 21.05.2025.
//

import SwiftUI

struct AppSettings: View {
    @EnvironmentObject var appearanceManager: AppAppearanceManager
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Toggle("Темная тема", isOn: Binding(get: { appearanceManager.isDarkMode }, set: { newValue in appearanceManager.isDarkMode = newValue }))
                .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                .padding(.vertical, 19)
            HStack {
                Text("Пользовательское соглашение")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.primary)
                    .imageScale(.large)
            }
            .padding(.vertical, 19)
            .clipShape(Rectangle())
            .onTapGesture {
                path.append("UserAgreementView")
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
}

#Preview {
    AppSettings( path: .constant(NavigationPath()))
}
