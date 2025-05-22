import SwiftUI
import SDWebImageSVGCoder

@main
struct TravelScheduleApp: App {
    @StateObject var appearanceManager = AppAppearanceManager()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = UIColor.shadow
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appearanceManager)
        }
    }
}

