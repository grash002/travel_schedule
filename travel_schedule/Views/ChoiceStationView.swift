//
//  ChoiceStationView.swift
//  travel_schedule
//
//  Created by Иван Иван on 14.05.2025.
//

import SwiftUI

struct ChoiceStationView: View {
    @ObservedObject var viewModel: ChoiceStationViewModel
    @Binding var selectedStation: Station
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredStation) { station in
                    ChoiceStationRowView(station: station)
                        .onTapGesture {
                            selectedStation.name = station.name
                            selectedStation.code = station.code
                            DispatchQueue.main.async {
                                path.removeLast(path.count)
                            }
                            if #available(iOS 18, *) { //Окно не закрывается, если использовали поиск "searchable" в предыдущем окне в iOS 18
                                dismiss()
                            }
                        }
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
                Text("Выбор станции")
                    .font(.system(size: 17, weight: .bold))
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    ChoiceStationView(viewModel: ChoiceStationViewModel(city: "Москва"),
                      selectedStation: .constant(Station(name: "", code: "")),
                      path: .constant(NavigationPath()))
}
