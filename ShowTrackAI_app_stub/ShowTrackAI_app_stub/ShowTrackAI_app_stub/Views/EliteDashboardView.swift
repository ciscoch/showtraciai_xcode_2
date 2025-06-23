import SwiftUI
import Supabase

struct EliteDashboardView: View {
    var body: some View {
        TabView {
            AnimalsTab()
                .tabItem { Label("Animals", systemImage: "hare") }
            
            JournalTab()
                .tabItem { Label("Journal", systemImage: "book") }
            
            ExpensesTab()
                .tabItem { Label("Expenses", systemImage: "dollarsign") }
            
            WeightTrackerTab()
                .tabItem { Label("Weights", systemImage: "scalemass") }
            
            Text("Growth AI (coming soon)")
                .tabItem { Label("Growth", systemImage: "chart.bar") }
        }
        .navigationTitle("Elite Dashboard")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Log Out") {
                    SupabaseManager.shared.role = ""
                }
            }
        }
    }
}
