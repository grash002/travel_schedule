//
//  TripSettings.swift
//  travel_schedule
//
//  Created by Иван Иван on 20.05.2025.
//

import SwiftUI

//MARK: - TripSettings

struct TripSettings: View {
    
    //MARK: - Properties
    @StateObject var viewModel: TripSettingsViewModel
    @Binding var path: NavigationPath
    
    //MARK: - Content
    
    var body: some View {
        settingView
            .navigationBarBackButtonHidden(true)
            .toolbar {
                backToolBarContent
            }
    }
    
    //MARK: - Views
    
    private var settingView: some View {
        ZStack {
            VStack(spacing: 16) {
                timeSettingView
                transferSettingView
            }
            .padding(.top, 16)
            .padding(.horizontal, 19)
            buttonApply
        }
    }
    private var transferSettingView: some View {
        VStack(alignment: .leading,spacing: 35) {
            Text("Показывать варианты с пересадками")
                .font(.system(size: 24,weight: .bold))
            VStack {
                TripSettingsRow(text: "Да", checkBox: .Circle, checked: Binding(get: { viewModel.checked.hasTransfer }, set: {newValue in viewModel.checked.hasTransfer = newValue}))
                TripSettingsRow(text: "Нет", checkBox: .Circle, checked: Binding(get: { !viewModel.checked.hasTransfer }, set: {newValue in viewModel.checked.hasTransfer = !newValue}))
            }
            Spacer()
        }
    }
    private var timeSettingView: some View {
        VStack(alignment: .leading,spacing: 35) {
            Text("Время отправления")
                .font(.system(size: 24,weight: .bold))
            VStack {
                TripSettingsRow(text: "Утро 06:00 - 12:00", checkBox: .Rectangle, checked: Binding(get: { viewModel.checked.morningCheck }, set: {newValue in viewModel.checked.morningCheck = newValue}))
                TripSettingsRow(text: "День 12:00 - 18:00", checkBox: .Rectangle, checked: Binding(get: { viewModel.checked.afternoonCheck }, set: {newValue in viewModel.checked.afternoonCheck = newValue}))
                TripSettingsRow(text: "Вечер 18:00 - 00:00", checkBox: .Rectangle, checked: Binding(get: { viewModel.checked.eveningCheck }, set: {newValue in viewModel.checked.eveningCheck = newValue}))
                TripSettingsRow(text: "Ночь 00:00 - 06:00", checkBox: .Rectangle, checked: Binding(get: { viewModel.checked.nightCheck }, set: {newValue in viewModel.checked.nightCheck = newValue}))
            }
            Spacer()
        }
    }
    private var buttonApply: some View {
        VStack {
            Spacer()
            Button {
                viewModel.onTap()
                path.removeLast()
            } label: {
                Text("Применить")
                    .font(.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
            }
        }
        .padding(.bottom, 24)
        .opacity( viewModel.isButtonEnabled() ? 1 : 0)
        .disabled( !viewModel.isButtonEnabled() )
    }
    
    // MARK: - ToolBarContent
    
    private var backToolBarContent: some ToolbarContent {
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

//MARK: - Preview

#Preview {
    
    TripSettings(viewModel: TripSettingsViewModel(checked: SettingsCheck(), onTap: {}), path: .constant(NavigationPath()))
    
}
