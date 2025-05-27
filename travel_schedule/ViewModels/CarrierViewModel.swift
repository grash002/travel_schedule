//
//  CarrierViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 28.05.2025.
//

import Foundation

// MARK: - CarrierViewModel
@MainActor
final class CarrierViewModel: ObservableObject {
    @Published var carrier: Carrier
    
    init (carrier: Carrier) {
        self.carrier = carrier
    }
}
