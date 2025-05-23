import SwiftUI
import SDWebImageSVGCoder

// MARK: - TravelScheduleApp

@main
struct TravelScheduleApp: App {
    
    // MARK: - Public properties
    
    @StateObject var appearanceManager = AppAppearanceManager()
    
    // MARK: - Initializers
    
    init() {
        setupAppearance()
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
    
    // MARK: - Content
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appearanceManager)
        }
    }
    
    // MARK: - Private methods
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = UIColor.shadow
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

