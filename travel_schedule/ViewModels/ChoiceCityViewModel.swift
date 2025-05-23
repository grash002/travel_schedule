//
//  ChoiceCityViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 06.05.2025.
//

import Combine

// MARK: - ChoiceCityViewModel

final class ChoiceCityViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var cities: [City] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var error: CustomError?
    var stationsResponse: StationList? = nil
    var filteredCity: [City] {
        guard !searchText.isEmpty else { return Array(cities.prefix(10)) }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                             .prefix(10)
                             .map { $0 }
    }
  
    // MARK: - Private properties
    
    private let trainSearchService = TrainSearchService.shared
    
    // MARK: - Initializers
    
    init() {
        Task { @MainActor in
            do {
                try await stationList()
            } catch let customError as CustomError {
                self.error = customError
                print("Error stationList", self.error ?? "")
            } catch {
                self.error = .ServerError
                print("Error stationList", self.error ?? "")
            }
        }
    }
    
    // MARK: - Private methods
    
    @MainActor
    private func stationList() async throws {
        isLoading = true
        defer { isLoading = false }
        if let country =  stationsResponse?.countries?.filter({ $0.title == "Россия"}){
            stationsResponse = StationList(countries: Array(country))
        }
        guard stationsResponse == nil else {
            parseStations()
            return
        }
        stationsResponse = try await trainSearchService.getStationList()
        parseStations()
        
    }
    @MainActor
    private func parseStations() {
        guard let country = stationsResponse?.countries?.first(where: { $0.title == "Россия" }) else { return }
        
        let loadedStations: [City] = country.regions?.flatMap { region in
            region.settlements?.compactMap { settlement in
                guard let title = settlement.title, !title.isEmpty else { return nil }
                return City(name: title)
            } ?? []
        } ?? []
        cities = loadedStations
    }
}
