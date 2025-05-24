//
//  File.swift
//  travel_schedule
//
//  Created by Иван Иван on 17.04.2025.
//

import Foundation

typealias NearestStations = Components.Schemas.Stations
typealias Search = Components.Schemas.searchResponse
typealias Schedule = Components.Schemas.ScheduleResponse
typealias Thread = Components.Schemas.ThreadResponse
typealias NearestSettlement = Components.Schemas.NearestSettlementResponse
typealias CarrierResponse = Components.Schemas.CarrierResponse
typealias StationList = Components.Schemas.StationsListResponse
typealias Copyright = Components.Schemas.CopyrightResponse


protocol TrainSearchServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func getSearch(from: String, to: String, date: String, hasTransfers: Bool) async throws -> Search
    func getSchedule(station: String) async throws -> Schedule
    func getThread(uid: String)  async throws -> Thread
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement
    func getCarrier(code: String) async throws -> CarrierResponse
    func getStationList() async throws -> StationList
}
