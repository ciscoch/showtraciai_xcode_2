//
//  AdminDashboardView.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI

struct AdminDashboardView: View {
    @EnvironmentObject var auth: AdminAuthStore
    
    var body: some View {
        NavigationStack {
            TabView {
                AccountMaintenanceTab()
                    .tabItem {
                        Label("Accounts", systemImage: "person.3")
                    }
                
                AnalyticsTab()
                    .tabItem {
                        Label("Analytics", systemImage: "chart.bar")
                    }
            }
            .navigationTitle("Admin Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        auth.logout()
                    }
                }
            }
        }
    }
}

#Preview {
    AdminDashboardView()
        .environmentObject(AdminAuthStore())
}
