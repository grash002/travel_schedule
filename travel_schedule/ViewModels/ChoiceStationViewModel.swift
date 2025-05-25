//
//  ChoiceStationViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 13.05.2025.
//

import Foundation

    // MARK: - ChoiceStationViewModel

final class ChoiceStationViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var stationsInCity: [Station] = []
    @Published var searchText = ""
    var stations: StationList?
    var filteredStation: [Station] {
        guard !searchText.isEmpty else { return Array(stationsInCity.prefix(10)) }
        return stationsInCity.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                             .prefix(10)
                             .map { $0 }
    }
    
    // MARK: - Initializers
    
    init(city: String, stations: StationList? = nil) {
        self.stations = stations
        getStations(city: city)
    }
    
    // MARK: - Public methods
    
    func getStations(city: String) {
        guard !city.isEmpty else { return }
        var resultStations: [Station] = []
        stations?.countries?.forEach({ country in
            country.regions?.forEach({ region in
                let filteredRegion = region.settlements?.filter({ $0.title == city})
                filteredRegion?.first?.stations?.forEach({ station in
                    if let title = station.title,
                       let code = station.codes?.yandex_code {
                        resultStations.append(Station(name: title, code: code))
                    }
                })
            })
        })
        self.stationsInCity = resultStations
    }
}
