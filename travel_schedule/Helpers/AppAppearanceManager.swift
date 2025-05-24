//
//  AppereanceManadger.swift
//  travel_schedule
//
//  Created by Иван Иван on 21.05.2025.
//

import UIKit

class AppAppearanceManager: ObservableObject {
    @Published var isDarkMode: Bool = false {
        didSet {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.windows.forEach { window in
                window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }
        }
    }
}
