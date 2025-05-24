//
//  ChoiceStationView.swift
//  travel_schedule
//
//  Created by Иван Иван on 14.05.2025.
//

import SwiftUI

// MARK: - ChoiceStationView

struct ChoiceStationView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ChoiceStationViewModel
    @Binding var selectedStation: Station
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Properties
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredStation) { station in
                    rowView(station)
                }
            }
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backToolBarContent
            titleToolBarContent
        }
    }
    
    @ViewBuilder
    private func rowView(_ station: Station) -> some View {
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
            Text("Выбор города")
                .font(.system(size: 17,weight: .bold))
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Preview

#Preview {
    ChoiceStationView(viewModel: ChoiceStationViewModel(city: "Москва"),
                      selectedStation: .constant(Station(name: "", code: "")),
                      path: .constant(NavigationPath()))
}
