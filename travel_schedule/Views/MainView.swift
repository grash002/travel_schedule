//
//  MainView.swift
//  travel_schedule
//
//  Created by Иван Иван on 07.05.2025.
//

import SwiftUI

struct MainView: View {
    @State var departurePoint: Station = Station(name: "", code: "")
    @State var arrivalPoint: Station = Station(name: "", code: "")
    @ObservedObject var viewModel = MainViewModel()
    @State private var isNavigated: Bool = false
    
    @StateObject var listOfTripsViewModel = ListOfTripsViewModel(departurePoint: Station(name: "", code: ""), arrivalPoint: Station(name: "", code: ""))
    @State private var selectedStation: String?
    @State private var selectedCity: String?
    
    @State var selectedField: SelectedField? = nil
    @State var settings = SettingsCheck()
    @State private var path = NavigationPath()
    private let choiceCityViewModel: ChoiceCityViewModel = ChoiceCityViewModel()
    
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                ZStack {
                    Color(uiColor: .systemBackground)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 16) {
                        SearchTrainView(departurePoint: $departurePoint,
                                        arrivalPoint: $arrivalPoint, selectedField: $selectedField,path: $path)
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        Button {
                            path.append("ListOfTripsView")
                        } label: {
                            Text("Найти")
                                .font(.system(size: 17, weight: .bold))
                                .frame(width: 150, height: 60)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(16)
                        }
                        .opacity(arrivalPoint.name.isEmpty == false && departurePoint.name.isEmpty == false ? 1 : 0)
                        .disabled(arrivalPoint.name.isEmpty == true || departurePoint.name.isEmpty == true)
                        
                        Spacer()
                    }
                }
                .tabItem {
                    Label("", systemImage: "arrow.up.message.fill")
                }
                
                AppSettings(path: $path)
                    .tabItem {
                        Label("", systemImage: "gearshape.fill")
                    }
            }
            .tint(.primary)
            .navigationDestination(for: SelectedField.self) { field in
                ChoiceCityView(selectedCity: $selectedCity,
                               path: $path,
                               viewModel: choiceCityViewModel) {
                    if let city = selectedCity {
                        path.append(CitySelection(city: city, field: field))
                    }
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "ListOfTripsView" {
                    
                    ListOfTripsView(departurePoint: $departurePoint,
                                    arrivalPoint: $arrivalPoint,
                                    path: $path,
                                    viewModel: listOfTripsViewModel)
                    .onAppear() {
                        listOfTripsViewModel.departurePoint = departurePoint
                        listOfTripsViewModel.arrivalPoint = arrivalPoint
                        Task {
                            await listOfTripsViewModel.updateFilteredTrips(newSettings: nil)
                        }
                    }
                } else if value == "TripSettingsView" {
                    TripSettings(checked: $settings, path: $path, onTap: {
                        Task {
                            await listOfTripsViewModel.updateFilteredTrips(newSettings: settings)
                        }
                    })
                } else if value == "UserAgreementView" {
                    UserAgreementView(path: $path)
                }
            }
            .navigationDestination(for: CitySelection.self) { citySelection in
                ChoiceStationView(
                    viewModel: ChoiceStationViewModel(city: citySelection.city,
                                                      stations: choiceCityViewModel.stationsResponse),
                    selectedStation: citySelection.field == .arrival ? $arrivalPoint : $departurePoint,
                    path: $path
                )
            }
            
            .navigationDestination(for: Carrier.self) { carrier in
                CarrierView(path: $path, carrier: carrier)
            }
        }
    }
}

#Preview {
    ContentView()
}
