import SwiftUI
import Supabase

struct BuyerDashboardView: View {
    var body: some View {
        NavigationStack {
            TabView {
                WatchlistTab()
                    .tabItem { Label("Watchlist", systemImage: "eye") }
                
                Text("Market (coming soon)")
                    .tabItem { Label("Market", systemImage: "chart.line.uptrend.xyaxis") }
            }
            .navigationTitle("Buyer Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Log Out") {
                        SupabaseManager.shared.role = ""
                    }
                }
            }
        }
    }
}
