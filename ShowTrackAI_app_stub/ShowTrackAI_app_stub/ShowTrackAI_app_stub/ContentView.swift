import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: RootRouter
    
    var body: some View {
        Group {
            switch router.current {
            case .login:
                LoginView()
            case .userDash:
                UserDashboardView()
            case .eliteDash:
                EliteDashboardView()
            case .buyerDash:
                BuyerDashboardView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(RootRouter())
}
