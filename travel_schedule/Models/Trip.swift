//
//  Trip.swift
//  travel_schedule
//
//  Created by Иван Иван on 07.05.2025.
//

import Foundation

struct Trip: Identifiable, Hashable {
    let id = UUID()
    let logoSVG: String
    let date: Date
    let startTime: Date
    let endTime: Date
    let duration: Double
    let carrierTitle: String
    let transfer: Bool?
    let carrier: Carrier
}
