import SwiftUI
import Supabase

struct LoginView: View {
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Login Screen")
                .font(.largeTitle.bold())
            
            Button("Fake Sign‑In (Elite)") {
                SupabaseManager.shared.role = "elite"
            }
            .buttonStyle(.borderedProminent)
            
            Button("Fake Sign‑In (Free)") {
                SupabaseManager.shared.role = "free"
            }
            .buttonStyle(.bordered)
            
            Button("Enter Buyer Mode") {
                SupabaseManager.shared.role = "buyer"
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
