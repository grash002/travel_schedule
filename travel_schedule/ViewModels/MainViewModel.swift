//
//  MainViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 07.05.2025.
//

import SwiftUI

    // MARK: - MainViewModel

final class MainViewModel:ObservableObject {
    
    // MARK: - Public properties
    
    @Published var departurePoint: Station = Station(name: "", code: "")
    @Published var arrivalPoint: Station = Station(name: "", code: "")
    @Published var isNavigated: Bool = false
    @Published var selectedStation: String?
    @Published var selectedCity: String?
    @Published var selectedField: SelectedField? = nil
    @Published var settings = SettingsCheck()
    @Published var path = NavigationPath()
    let choiceCityViewModel: ChoiceCityViewModel = ChoiceCityViewModel()
    let listOfTripsViewModel = ListOfTripsViewModel(departurePoint: Station(name: "", code: ""), arrivalPoint: Station(name: "", code: ""))
    var isSearchButtonEnabled: Bool {
        !departurePoint.name.isEmpty && !arrivalPoint.name.isEmpty
    }
    lazy var tripSettingsViewModel = TripSettingsViewModel(checked: settings, onTap: {
        Task {
            await self.listOfTripsViewModel.updateFilteredTrips(newSettings: self.settings)
        }
    })
    let appSettingsViewModel = AppSettingsViewModel()
    
    // MARK: - Public methods
    
    func updateTripSearch() async {
        listOfTripsViewModel.departurePoint = departurePoint
        listOfTripsViewModel.arrivalPoint = arrivalPoint
        await listOfTripsViewModel.updateFilteredTrips(newSettings: nil)
    }
    
    func refreshListOfTrips() {
        guard !listOfTripsViewModel.filteredTrips.isEmpty else { return }
        Task {
            await listOfTripsViewModel.updateFilteredTrips(newSettings: nil)
        }
    }
}
