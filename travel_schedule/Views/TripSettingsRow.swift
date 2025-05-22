//
//  TripSettingsRow.swift
//  travel_schedule
//
//  Created by Иван Иван on 20.05.2025.
//

import SwiftUI

struct TripSettingsRow: View {
    var text: String
    var checkBox: CheckBox
    @Binding var checked: Bool
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 17))
            Spacer()
            
            Button(action: {
                checked.toggle()
            }) {
                if checkBox == .Rectangle {
                    Image(systemName: checked ? "checkmark.square.fill" : "square")
                        .foregroundColor(.primary)
                        .font(.system(size: 20))
                } else if checkBox == .Circle {
                    Image(systemName: checked ? "circle.inset.filled" : "circle")
                        .foregroundColor(.primary)
                        .font(.system(size: 20))
                }
            }
        }
        .padding(.vertical, 19)
    }
}

#Preview {
    TripSettingsRow(text: "День 12:00 - 18:00", 
                    checkBox: .Circle,
                    checked: .constant(false))
}
