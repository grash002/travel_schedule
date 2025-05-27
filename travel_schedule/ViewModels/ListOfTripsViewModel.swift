//
//  ListOfCarriesViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 07.05.2025.
//

import Foundation

    // MARK: - ListOfTripsViewModel

@MainActor
final class ListOfTripsViewModel: ObservableObject {
   
    // MARK: - Public properties
    
    @Published var trips: [Trip] = []
    @Published var filteredTrips: [Trip] = []
    @Published var settings: SettingsCheck?
    @Published var isLoading = false
    @Published var error: CustomError?
    
    var departurePoint: Station
    var arrivalPoint: Station
    
    // MARK: - Private properties
    
    private let trainSearchService = TrainSearchService.shared
    private let formatter = DateFormatter()
 
    // MARK: - Initializers
    
    init(departurePoint: Station, arrivalPoint: Station) {
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        self.trips = []
        self.arrivalPoint = arrivalPoint
        self.departurePoint = departurePoint
        Task {
            await updateFilteredTrips(newSettings: nil)
        }
    }
    
    // MARK: - Public methods
    
    func formatDayMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.timeZone = TimeZone(secondsFromGMT: 3 * 3600)
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date)
    }

    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeZone = TimeZone(secondsFromGMT: 3 * 3600)
        return formatter.string(from: date)
    }
    
    func durationToString(_ duration: Double) -> String {
        String.localizedStringWithFormat(
            NSLocalizedString("numberOfHours", comment: "Number of hours"),
            Int((duration / 3600).rounded())
        )
    }
    
    @MainActor
    func updateFilteredTrips(newSettings: SettingsCheck?) async {
        
        isLoading = true
        defer { isLoading = false }
        
        if let newSettings {
            settings = newSettings
        }
        await getSearch()
        
        guard let settings else {
            filteredTrips = trips
            return
        }
        
        let result = trips.filter { trip in
            let time = trip.startTime
            return
            (settings.morningCheck && isTimeInPeriod(date: time, from: 6*60, to: 12*60)) ||
            (settings.afternoonCheck && isTimeInPeriod(date: time, from: 12*60, to: 18*60)) ||
            (settings.eveningCheck && isTimeInPeriod(date: time, from: 18*60, to: 24*60)) ||
            (settings.nightCheck && isTimeInPeriod(date: time, from: 0, to: 6*60))
        }
        
        filteredTrips = result.sorted { $0.date < $1.date || ($0.date == $1.date && $0.startTime < $1.startTime) } 
    }
    
    // MARK: - Private methods
    
    private func isTimeInPeriod(date: Date, from: Int, to: Int) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour,.minute], from: date)
        guard let hour = components.hour,
              let minute = components.minute else { return false }
        let totalMinute = hour * 60 + minute
        return totalMinute >= from && totalMinute <= to
    }
    
    @MainActor
    private func getSearch() async {
        var search:Search? = nil
        
        do {
            var result: [Trip] = []
            search =  try await trainSearchService.getSearch(from: departurePoint.code,
                                                             to: arrivalPoint.code,
                                                             date: "",
                                                             hasTransfers: settings?.hasTransfer ?? false
            )
            search?.segments?.forEach({segment in
                let trip = Trip(logoSVG: segment.thread?.carrier?.logo_svg ?? "",
                                date: formatter.date(from: "\(segment.start_date ?? "") 00:00:00") ?? Date(),
                                startTime: formatter.date(from: "1970/01/01 \(segment.departure ?? "")") ?? Date(),
                                endTime: formatter.date(from: "1970/01/01 \(segment.arrival ?? "")") ?? Date(),
                                duration: segment.duration ?? 0,
                                carrierTitle: segment.thread?.carrier?.title ?? "",
                                transfer: segment.has_transfers,
                                carrier: Carrier(name: segment.thread?.carrier?.title ?? "",
                                                 imageURL: URL(string: segment.thread?.carrier?.logo ?? ""),
                                                 email: segment.thread?.carrier?.email ?? "",
                                                 phone: segment.thread?.carrier?.phone ?? "")
                )
                result.append(trip)
            })
            self.trips = result
        } catch let customError as CustomError {
            self.error = customError
            print("Error stationList", self.error ?? "")
        } catch {
            self.error = .ServerError
            print("Error stationList", self.error ?? "")
        }
    }
}
