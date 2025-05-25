//
//  ChoiceCityRowView.swift
//  travel_schedule
//
//  Created by Иван Иван on 06.05.2025.
//

import SwiftUI

// MARK: - ChoiceCityRowView

struct ChoiceCityRowView: View {
    
    // MARK: - Properties
    
    let station: City
    
    // MARK: - Content
    
    var body: some View {
        HStack{
            Text(station.name)
                .font(.system(size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .contentShape(Rectangle())
    }
}


// MARK: - Preview

#Preview {
    ChoiceCityRowView(station: City(name: "Москва"))
}
