//
//  TripSettings.swift
//  travel_schedule
//
//  Created by Иван Иван on 20.05.2025.
//

import SwiftUI

struct TripSettings: View {
    
    @Binding var checked: SettingsCheck
    @Binding var path: NavigationPath
    var onTap: () -> Void
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading,spacing: 35) {
                    Text("Время отправления")
                        .font(.system(size: 24,weight: .bold))
                    VStack {
                        TripSettingsRow(text: "Утро 06:00 - 12:00", checkBox: .Rectangle, checked: Binding(get: { checked.morningCheck }, set: {newValue in checked.morningCheck = newValue}))
                        TripSettingsRow(text: "День 12:00 - 18:00", checkBox: .Rectangle, checked: Binding(get: { checked.afternoonCheck }, set: {newValue in checked.afternoonCheck = newValue}))
                        TripSettingsRow(text: "Вечер 18:00 - 00:00", checkBox: .Rectangle, checked: Binding(get: { checked.eveningCheck }, set: {newValue in checked.eveningCheck = newValue}))
                        TripSettingsRow(text: "Ночь 00:00 - 06:00", checkBox: .Rectangle, checked: Binding(get: { checked.nightCheck }, set: {newValue in checked.nightCheck = newValue}))
                    }
                    Spacer()
                }
                VStack(alignment: .leading,spacing: 35) {
                    Text("Показывать варианты с пересадками")
                        .font(.system(size: 24,weight: .bold))
                    VStack {
                        TripSettingsRow(text: "Да", checkBox: .Circle, checked: Binding(get: { checked.hasTransfer }, set: {newValue in checked.hasTransfer = newValue}))
                        TripSettingsRow(text: "Нет", checkBox: .Circle, checked: Binding(get: { !checked.hasTransfer }, set: {newValue in checked.hasTransfer = !newValue}))
                    }
                    Spacer()
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 19)
            VStack {
                Spacer()
                Button {
                    onTap()
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
            .opacity( checked.morningCheck || checked.afternoonCheck || checked.eveningCheck || checked.nightCheck ? 1 : 0)
            .disabled( !checked.morningCheck && !checked.afternoonCheck && !checked.eveningCheck && !checked.nightCheck )
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
    TripSettings(checked: .constant(SettingsCheck()),
                 path: .constant(NavigationPath()),
                 onTap: {})
}
