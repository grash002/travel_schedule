//
//  AppSettingsViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 23.05.2025.
//

import Foundation

// MARK: - AppSettingsViewModel

@MainActor
final class AppSettingsViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    var trainSearchService = TrainSearchService.shared
    @Published var copyrightText: String = ""
    
    // MARK: - Initializers
    
    init() {
        Task {
           await getCopyrightText()
        }
    }
    
    // MARK: - Public methods
    
    @MainActor
    func getCopyrightText() async {
        do {
            copyrightText = try await trainSearchService.getCopyright()
                .copyright?.text ?? ""
        } catch {
            print("Error getCopyrightText: ", error)
        }
    }
}
