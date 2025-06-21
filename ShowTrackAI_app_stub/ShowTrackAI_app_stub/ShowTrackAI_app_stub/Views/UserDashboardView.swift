import SwiftUI

struct UserDashboardView: View {
    var body: some View {
        NavigationStack {
            TabView {
                AnimalsTab()
                    .tabItem { Label("Animals", systemImage: "hare") }
                
                JournalTab()
                    .tabItem { Label("Journal", systemImage: "book") }
                
                ExpensesTab()
                    .tabItem { Label("Expenses", systemImage: "dollarsign") }
                
                WeightTrackerTab()
                    .tabItem { Label("Weights", systemImage: "scalemass") }
            }
            .navigationTitle("User Dashboard")
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
