//
//  ChoiceStationViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 13.05.2025.
//

import Foundation

final class ChoiceStationViewModel: ObservableObject {
    var stations: StationList?
    @Published var stationsInCity: [Station] = []
    @Published var searchText = ""
    
    var filteredStation: [Station] {
        guard !searchText.isEmpty else { return Array(stationsInCity.prefix(10)) }
        var result = [Station]()
        stationsInCity.forEach({ city in
            if city.name.lowercased().contains(searchText.lowercased()) {
                result.append(city)
            }
        })
        
        return Array(result.prefix(10))
    }
    
    init(city: String, stations: StationList? = nil) {
        self.stations = stations
        getStations(city: city)
    }
    
    
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
