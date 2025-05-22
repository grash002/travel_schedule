//
//  ChoiceCityView.swift
//  travel_schedule
//
//  Created by Иван Иван on 05.05.2025.
//

import SwiftUI

struct ChoiceCityView: View {
    @Binding var selectedCity: String?
    @Binding var path: NavigationPath
    @ObservedObject var viewModel: ChoiceCityViewModel
    @State var isNavigated = false
    var onSelected: () -> Void
    
    var body: some View {
        Group {
            if let error = viewModel.error {
                switch error {
                case .ServerError:
                    ServerErrorView()
                case .InternetError:
                    InternetErrorView()
                default:
                    ServerErrorView()
                }
            } else if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            else {
                if !viewModel.filteredCity.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.filteredCity) { station in
                                ChoiceCityRowView(station: station)
                                    .onTapGesture {
                                        selectedCity = station.name
                                        onSelected()
                                    }
                            }
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("Город не найден")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height)
                }
            }
        }
        .searchable(text: $viewModel.searchText)
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
            
            ToolbarItem(placement: .principal) {
                Text("Выбор города")
                    .font(.system(size: 17,weight: .bold))
                    .multilineTextAlignment(.center)
            }
        }
    }
}


#Preview {
    ChoiceCityView(selectedCity: .constant(""),
                   path: .constant(NavigationPath()),
                   viewModel: ChoiceCityViewModel()){ }
}
