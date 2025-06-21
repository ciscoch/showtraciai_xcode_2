import SwiftUI      // ← REQUIRED

@main
struct ShowTrackAI_app_stubApp: App {
    
    @StateObject private var router = RootRouter()
    @StateObject private var animalStore = AnimalStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .environmentObject(animalStore)
        }
    }
}
