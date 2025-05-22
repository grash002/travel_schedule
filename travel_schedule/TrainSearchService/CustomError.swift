//
//  Error.swift
//  travel_schedule
//
//  Created by Иван Иван on 17.04.2025.
//

import Foundation

enum CustomError: Error {
    case JsonFailed(String)
    case ClientNil
    case ServerError
    case InternetError
    case notFound
}
