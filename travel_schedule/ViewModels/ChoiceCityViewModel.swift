//
//  ChoiceCityViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 06.05.2025.
//

import Combine

final class ChoiceCityViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var error: CustomError?
    
    var stationsResponse: StationList? = nil
    
    var filteredCity: [City] {
        guard !searchText.isEmpty else { return Array(cities.prefix(10)) }
        var result = [City]()
        cities.forEach({ city in
            if city.name.lowercased().contains(searchText.lowercased()) {
                result.append(city)
            }
        })
        
        return Array(result.prefix(10))
    }
    
    private let trainSearchService = TrainSearchService.shared
    
    @MainActor
    private func stationList() async throws {
        isLoading = true
        defer { isLoading = false }

        var loadedStations: [City] = []
        if stationsResponse == nil {
            stationsResponse = try await trainSearchService.getStationList()
        }
        if let country =  stationsResponse?.countries?.filter({ $0.title == "Россия"}){
            stationsResponse = StationList(countries: Array(country))
        }
        
        stationsResponse?.countries?.forEach { country in
            country.regions?.forEach { region in
                region.settlements?.forEach { settlement in
                    if let title = settlement.title,
                       !title.isEmpty {
                        loadedStations.append(City(name: title))
                    }
                }
            }
        }

        cities = loadedStations
    }

    
    init() {
        Task { @MainActor in
            do {
                try await stationList()
            } catch let customError as CustomError {
                self.error = customError
                print("Error stationList", self.error)
            } catch {
                self.error = .ServerError
                print("Error stationList", self.error)
            }
        }
    }
}
