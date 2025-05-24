//
//  InternetErrorView.swift
//  travel_schedule
//
//  Created by Иван Иван on 19.05.2025.
//

import SwiftUI

//MARK: - InternetErrorView

struct InternetErrorView: View {
    
    //MARK: - Content
    
    var body: some View {
        VStack {
            Image("No Internet")
                .resizable()
                .frame(width: 223, height: 223)
            Text("Нет интернета")
                .font(.system(size: 24,
                              weight: .bold))
        }
    }
}

//MARK: - Preview

#Preview {
    InternetErrorView()
}
