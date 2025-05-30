//
//  CarrierView.swift
//  travel_schedule
//
//  Created by Иван Иван on 21.05.2025.
//

import SwiftUI

struct CarrierView: View {
    
    // MARK: - Properties
    
    @Binding var path: NavigationPath
    var carrier: Carrier
    
    // MARK: - Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            carrierTitleView
            emailView
            phoneView
            Spacer()
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backToolBarContent
            titleToolBarContent
        }
    }
    
    
    // MARK: - Views
    
    private var phoneView: some View {
        VStack(alignment: .leading) {
            Text("Телефон")
                .font(.system(size: 17))
            if let url = URL(string: "tel:\(carrier.phone)") {
                Link(destination: url, label: {
                    Text(carrier.phone)
                        .font(.system(size: 12))
                })
            }
        }
    }
    private var emailView: some View {
        VStack(alignment: .leading) {
            Text("E-mail")
                .font(.system(size: 17))
            if let url = URL(string: "mailto:\(carrier.email)") {
                Link(destination: url, label: {
                    Text(carrier.email)
                        .font(.system(size: 12))
                })
            }
        }
    }
    private var carrierTitleView: some View {
        Group {
            AsyncImage(url: carrier.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .cornerRadius(24)
                case .failure:
                    Image(systemName: "photo")
                        .frame(maxWidth: .infinity, alignment: .center)
                @unknown default:
                    EmptyView()
                }
            }
            Text(carrier.name)
                .font(.system(size: 24,weight: .bold))
        }
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
    private var titleToolBarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("Информация о перевозчике")
                .font(.system(size: 17,weight: .bold))
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Preview
#Preview {
    CarrierView(path: .constant(NavigationPath()),
                carrier: Carrier(name: "ОАО «РЖД»",
                                 imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logorus_1.jpg"),
                                 email: "rzd@mail.ru",
                                 phone: "+7 (900) 123-45-67"))
}
