//
//  ServerErrorView.swift
//  travel_schedule
//
//  Created by Иван Иван on 19.05.2025.
//

import SwiftUI

struct ServerErrorView: View {
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

#Preview {
    ServerErrorView()
}
