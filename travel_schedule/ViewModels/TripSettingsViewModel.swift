//
//  TripSettingsViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 23.05.2025.
//

import SwiftUI

// MARK: - TripSettingsViewModel

@MainActor
final class TripSettingsViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var checked: SettingsCheck
    let onTap: () -> Void
    
    // MARK: - Initializers
    
    init(checked: SettingsCheck, onTap: @escaping () -> Void) {
        self.checked = checked
        self.onTap = onTap
    }
    
    // MARK: - Public methods
    
    func isButtonEnabled() -> Bool {
        checked.morningCheck || checked.afternoonCheck || checked.eveningCheck || checked.nightCheck
    }
}
