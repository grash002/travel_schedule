//
//  NearestStationsService.swift
//  travel_schedule
//
//  Created by David G on 10.04.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation



final class TrainSearchService: TrainSearchServiceProtocol {
    
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSchedule(station: String) async throws -> Schedule {
        let response = try await client.getSchedule(query: .init(apikey: apikey, station: station))
        return try response.ok.body.json
    }
    
    func getSearch(from: String, to: String, date: String) async throws -> Search {
        let response = try await client.getSearch(query: .init(apikey: apikey, from: from, to: to))
        return try response.ok.body.json
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
    
    func getThread(uid: String) async throws -> Thread {
        let response = try await client.getThread(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
    
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng
        ))
        return try response.ok.body.json
    }
    
    func getCarrier(code: String) async throws -> Carrier {
        let response = try await client.getCarrier(query: .init(
            apikey: apikey,
            code: code
        ))
        return try response.ok.body.json
    }
    
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(apikey: apikey))
        return try response.ok.body.json
    }
    
    
    
    func getStationList() async throws -> StationList {
        let response = try await client.getStationsList(query: .init(
            apikey: apikey
        ))
        
        let body = try response.ok.body.html
        var buffer = Data()
        for try await chunk in body {
            buffer.append(contentsOf: chunk)
        }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(StationList.self, from: buffer)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted:", context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
        } catch {
            print("Unknown decoding error:", error)
            throw error
        }
        return StationList()
    }
}

