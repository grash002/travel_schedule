//
//  Carries.swift
//  travel_schedule
//
//  Created by Иван Иван on 07.05.2025.
//

import Foundation

struct Carrier:Identifiable, Hashable, Codable {
    let id = UUID()
    let name: String
    let imageURL: URL?
    let email: String
    let phone: String
}
