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
    @ObservedObject var viewModel: CarrierViewModel
    
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
            if let url = URL(string: "tel:\(viewModel.carrier.phone)") {
                Link(destination: url, label: {
                    Text(viewModel.carrier.phone)
                        .font(.system(size: 12))
                })
            }
        }
    }
    private var emailView: some View {
        VStack(alignment: .leading) {
            Text("E-mail")
                .font(.system(size: 17))
            if let url = URL(string: "mailto:\(viewModel.carrier.email)") {
                Link(destination: url, label: {
                    Text(viewModel.carrier.email)
                        .font(.system(size: 12))
                })
            }
        }
    }
    private var carrierTitleView: some View {
        Group {
            AsyncImage(url: viewModel.carrier.imageURL) { phase in
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
            Text(viewModel.carrier.name)
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
    let viewModel = CarrierViewModel(carrier: Carrier(name: "ОАО «РЖД»",
                                                      imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logorus_1.jpg"),
                                                      email: "rzd@mail.ru",
                                                      phone: "+7 (900) 123-45-67"))
    return CarrierView(path: .constant(NavigationPath()),
                viewModel: viewModel)
}
