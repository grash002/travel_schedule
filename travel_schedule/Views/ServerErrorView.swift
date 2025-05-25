//
//  ServerErrorView.swift
//  travel_schedule
//
//  Created by Иван Иван on 19.05.2025.
//

import SwiftUI

//MARK: - ServerErrorView

struct ServerErrorView: View {
    
    //MARK: - Content
    
    var body: some View {
        VStack {
            Image("Server Error")
                .resizable()
                .frame(width: 223, height: 223)
            Text("Ошибка сервера")
                .font(.system(size: 24,
                              weight: .bold))
        }
    }
}

//MARK: - Preview

#Preview {
    ServerErrorView()
}
