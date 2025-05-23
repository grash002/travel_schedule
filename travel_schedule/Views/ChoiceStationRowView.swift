//
//  SwiftUIView.swift
//  travel_schedule
//
//  Created by Иван Иван on 14.05.2025.
//

import SwiftUI

//MARK: - ChoiceStationRowView

struct ChoiceStationRowView: View {
    
    //MARK: - Properties
    
    let station: Station
    
    //MARK: - Content
    
    var body: some View {
        HStack{
            Text(station.name)
                .font(.system(size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "chevron.right")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
    }
}

//MARK: - Preview

#Preview {
    ChoiceCityRowView(station: City(name: "Москва"))
}
