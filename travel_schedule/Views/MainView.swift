//
//  MainView.swift
//  travel_schedule
//
//  Created by Иван Иван on 07.05.2025.
//

import SwiftUI

// MARK: - MainView

struct MainView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel = MainViewModel()
    
    // MARK: - Content
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            TabView {
                ZStack {
                    Color(uiColor: .systemBackground)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 44) {
                        PreviewStoriesView(viewModel: viewModel.fullStoriesViewModel, path: $viewModel.path)
                            .padding(.leading, 16)
                        searchTrainView
                    }
                }
                .tabItem {
                    Label("", systemImage: "arrow.up.message.fill")
                }
                AppSettings(path: $viewModel.path, viewModel: viewModel.appSettingsViewModel)
                    .tabItem {
                        Label("", systemImage: "gearshape.fill")
                    }
            }
            .tint(.primary)
            .navigationDestination(for: SelectedField.self) { field in
                ChoiceCityView(selectedCity: $viewModel.selectedCity,
                               path: $viewModel.path,
                               viewModel: viewModel.choiceCityViewModel) {
                    if let city = viewModel.selectedCity {
                        viewModel.path.append(CitySelection(city: city, field: field))
                    }
                }
            }
            .navigationDestination(for: String.self) { value in
                stringDestination(value)
            }
            .navigationDestination(for: CitySelection.self) { city in
                cityDestination(city)
            }
            .navigationDestination(for: Carrier.self) { carrier in
                Task {
                    viewModel.carrierViewModel.carrier = carrier
                }
                return CarrierView(path: $viewModel.path, viewModel: viewModel.carrierViewModel)
            }
        }
    }
    
    //MARK: - Views
    
    private var searchTrainView: some View {
        VStack(spacing: 16) {
            SearchTrainView(departurePoint: $viewModel.departurePoint,
                            arrivalPoint: $viewModel.arrivalPoint,
                            selectedField: $viewModel.selectedField,
                            path: $viewModel.path)
            Button {
                viewModel.refreshListOfTrips()
                viewModel.path.append("ListOfTripsView")
            } label: {
                Text("Найти")
                    .font(.system(size: 17, weight: .bold))
                    .frame(width: 150, height: 60)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(16)
            }
            .opacity(viewModel.isSearchButtonEnabled ? 1 : 0)
            .disabled(!viewModel.isSearchButtonEnabled)
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    //MARK: - View builders
    
    @ViewBuilder
    private func stringDestination(_ value: String) -> some View {
        switch value {
        case "ListOfTripsView":
            ListOfTripsView(departurePoint: $viewModel.departurePoint,
                            arrivalPoint: $viewModel.arrivalPoint,
                            path: $viewModel.path,
                            viewModel: viewModel.listOfTripsViewModel)
            .onAppear() {
                Task {
                    await viewModel.updateTripSearch()
                }
            }
        case "TripSettingsView":
            TripSettings(viewModel: viewModel.tripSettingsViewModel, path: $viewModel.path)
            
        case "UserAgreementView":
            UserAgreementView(path: $viewModel.path)
        case "FullStoriesView":
            FullStoriesView(path: $viewModel.path, viewModel: viewModel.fullStoriesViewModel)
        default:
            EmptyView()
        }
    }
    @ViewBuilder
    private func cityDestination(_ citySelection: CitySelection) -> some View {
        ChoiceStationView(
            viewModel: ChoiceStationViewModel(city: citySelection.city,
                                              stations: viewModel.choiceCityViewModel.stationsResponse),
            selectedStation: citySelection.field == .arrival ? $viewModel.arrivalPoint : $viewModel.departurePoint,
            path: $viewModel.path
        )
    }
}

//MARK: - Preview

#Preview {
    ContentView()
}
