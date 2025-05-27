//
//  AppSettings.swift
//  travel_schedule
//
//  Created by Иван Иван on 21.05.2025.
//

import SwiftUI

// MARK: - AppSettings

struct AppSettings: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appearanceManager: AppAppearanceManager
    @Binding var path: NavigationPath
    @StateObject var viewModel: AppSettingsViewModel
    
    // MARK: - Content
    
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
                VStack(alignment: .center, spacing: 16) {
                    Text("\(viewModel.copyrightText)")
                    Text("Версия 1.0 (beta)")
                }
                .font(.system(size: 12))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
        
    }
}

// MARK: - Preview

#Preview {
    AppSettings( path: .constant(NavigationPath()), viewModel: AppSettingsViewModel())
}
