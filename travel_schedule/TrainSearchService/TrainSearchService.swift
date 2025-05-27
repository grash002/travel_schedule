//
//  NearestStationsService.swift
//  travel_schedule
//
//  Created by David G on 10.04.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation


actor TrainSearchService: TrainSearchServiceProtocol {
    
    static let shared = TrainSearchService()
    
    private lazy var client: Client? = {
        do {
            return try Client(
                serverURL: Servers.Server1.url(),
                transport: URLSessionTransport()
            )
        } catch {
            print("Ошибка при создании клиента: \(error)")
            return nil
        }
    }()
    
    private let apiKey: String = Config.apiKey
    
    private init() { }
    
    func getSchedule(station: String) async throws -> Schedule {
        guard let client else { throw  CustomError.ClientNil}
        let response = try await client.getSchedule(query: .init(apikey: apiKey, station: station))
        return try response.ok.body.json
    }
    
    func getSearch(from: String, to: String, date: String, hasTransfers: Bool) async throws -> Search {
        guard let client else { throw  CustomError.ClientNil}
        let response = try await client.getSearch(query: .init(apikey: apiKey, from: from, to: to, transfers: hasTransfers))
        return try response.ok.body.json
        switch response {
        case .ok(let okResponse):
            let search = try okResponse.body.json
        case .undocumented(statusCode: 404, UndocumentedPayload()):
            throw CustomError.notFound
        default:
            throw CustomError.ServerError
        }
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        guard let client else { throw  CustomError.ClientNil}
        let response = try await client.getNearestStations(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
    
    func getThread(uid: String) async throws -> Thread {
        guard let client else { throw  CustomError.ClientNil}
        let response = try await client.getThread(query: .init(
            apikey: apiKey,
            uid: uid
        ))
        return try response.ok.body.json
    }
    
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        guard let client else { throw  CustomError.ClientNil}
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng
        ))
        return try response.ok.body.json
    }
    
    func getCarrier(code: String) async throws -> CarrierResponse {
        guard let client else { throw  CustomError.ClientNil}
        let response = try await client.getCarrier(query: .init(
            apikey: apiKey,
            code: code
        ))
        return try response.ok.body.json
    }
    
    
    func getCopyright() async throws -> Copyright {
        guard let client else { throw  CustomError.ClientNil}
        let response = try await client.getCopyright(query: .init(apikey: apiKey))
        return try response.ok.body.json
    }
    
    
    
    func getStationList() async throws -> StationList {
        guard let client else {
            throw  CustomError.ClientNil
        }
        do {
            let response = try await client.getStationsList(query: .init(
                apikey: apiKey
            ))
            
            let body = try response.ok.body.html
            var buffer = Data()
            for try await chunk in body {
                buffer.append(contentsOf: chunk)
            }
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(StationList.self, from: buffer)
            } catch {
                print("Decoding error:", error)
                throw error
            }
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet, .timedOut:
                throw CustomError.InternetError
            default:
                print("URLError:", urlError)
                throw CustomError.ServerError
            }
        } catch {
            print("Unknown error:", error)
            throw CustomError.ServerError
        }
        
    }
}

