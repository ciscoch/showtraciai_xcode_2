//
//  ShowTrackAI_app_stubApp.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI

@main
struct ShowTrackAI_app_stubApp: App {
    @StateObject private var router = RootRouter()
    @StateObject private var animalStore = AnimalStore()
    @StateObject private var journalStore = JournalStore()
    @StateObject private var adminAuth = AdminAuthStore()   // local dummy auth
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .environmentObject(animalStore)
                .environmentObject(journalStore)
                .environmentObject(adminAuth)
        }
    }
}
