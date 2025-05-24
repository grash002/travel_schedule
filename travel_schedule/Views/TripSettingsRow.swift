//
//  TripSettingsRow.swift
//  travel_schedule
//
//  Created by Иван Иван on 20.05.2025.
//

import SwiftUI

//MARK: - TripSettingsRow

struct TripSettingsRow: View {
    
    //MARK: - Properties
    
    var text: String
    var checkBox: CheckBox
    @Binding var checked: Bool
    
    
    //MARK: - Content
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 17))
            Spacer()
            
            Button(action: { checked.toggle() }) {
                Image(systemName: {
                    switch checkBox {
                    case .Circle:
                        return checked ? "circle.inset.filled" : "circle"
                    case .Rectangle:
                        return checked ? "checkmark.square.fill" : "square"
                    }
                }())
                    .foregroundColor(.primary)
                    .font(.system(size: 20))
                
            }
        }
        .padding(.vertical, 19)
    }
}

//MARK: - Preview

#Preview {
    TripSettingsRow(text: "День 12:00 - 18:00", 
                    checkBox: .Circle,
                    checked: .constant(false))
}
