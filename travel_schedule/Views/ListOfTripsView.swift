//
//  ListOfCarries.swift
//  travel_schedule
//
//  Created by Иван Иван on 07.05.2025.
//

import SwiftUI

// MARK: - ListOfTripsView

struct ListOfTripsView: View {
    
    // MARK: - Properties
    
    @Binding var departurePoint: Station
    @Binding var arrivalPoint: Station
    @Binding var path: NavigationPath
    @ObservedObject var viewModel: ListOfTripsViewModel
    
    // MARK: - Content
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                loadingView
            } else if viewModel.filteredTrips.isEmpty {
                emptyState
            }
            mainView
            
        }
    }
    
    // MARK: - Views
    
    private var loadingView: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
    private var emptyState: some View {
        Text("Вариантов нет")
            .font(.system(size: 24, weight: .bold))
    }
    private var mainView: some View {
        VStack {
            titleSection
            Spacer()
            tripListSection
        }
    }
    private var titleSection: some View {
        Text("\(departurePoint.name) → \(arrivalPoint.name)")
            .multilineTextAlignment(.leading)
            .font(.system(size: 24, weight: .bold))
            .padding(16)
    }
    private var filterButton: some View {
        VStack {
            Spacer()
            Button {
                path.append("TripSettingsView")
            } label: {
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
            }
        }
    }
    private var tripListSection: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.filteredTrips, id: \.id)  { trip in
                        ListOfTripsRowView(trip: trip, viewModel: viewModel)
                            .onTapGesture {
                                path.append(trip.carrier)
                            }
                    }
                }
                .padding(16)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar { toolBarContent }
            filterButton
        }
    }
    
    //MARK: - Toolbar
    
    private var toolBarContent: some ToolbarContent {
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
}

// MARK: - Preview

#Preview {
    ListOfTripsView(departurePoint: .constant(Station(name: "Москва (Ярославский вокзал)", code: "")),
                    arrivalPoint: .constant(Station(name: "Санкт Петербург (Балтийский вокзал)", code: "")),
                    path: .constant(NavigationPath()),
                    viewModel: ListOfTripsViewModel(departurePoint: Station(name: "Москва (Ярославский вокзал)", 
                                                                            code: ""),
                                                    arrivalPoint: Station(name: "Санкт Петербург (Балтийский вокзал)",
                                                                          code: "")))
}
