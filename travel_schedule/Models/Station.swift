//
//  Station.swift
//  travel_schedule
//
//  Created by Иван Иван on 13.05.2025.
//

import Foundation

struct Station: Identifiable, Hashable {
    
    let id = UUID()
    var name: String
    var code: String
}
