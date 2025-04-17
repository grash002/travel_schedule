//
//  ViewController.swift
//  travel_schedule
//
//  Created by David G on 05.04.2025.
//

import UIKit
import OpenAPIURLSession

class MainViewController: UIViewController {
    
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
    
    private lazy var service: TrainSearchService? = {
        guard let client else {
            return nil
        }
        return TrainSearchService(
            client: client,
            apikey: "ApiKey"
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        //station()
        //search()
        //schedule()
        //thread()
        //settlement()
        //carrier()
        //stationList()
        //copyright()
    }
    
    func station() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getNearestStations(lat: 55.776501420708016,
                                                                    lng: 37.657833455381116,
                                                                    distance: 50)
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
    
    func copiright() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getCopyright()
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
    
    
    func search() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getSearch(from: "s9637948", to: "s9761890", date: "2025-04-14")
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
    
    func schedule() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getSchedule(station: "s2000002")
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
    
    func thread() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getThread(uid: "empty_4_f9623369t9761925_114")
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
    
    func settlement() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163)
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
    
    func carrier() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getCarrier(code: "112")
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
    
    func stationList() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getCarrier(code: "112")
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
    
    func copyright() {
        guard let service else { return }
        Task {
            do {
                let result = try await service.getCopyright()
                print(result)
            } catch {
                print("Ошибка при получении станции: \(error)")
            }
        }
    }
}

