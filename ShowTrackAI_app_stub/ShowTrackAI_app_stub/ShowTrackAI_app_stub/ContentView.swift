import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var router: RootRouter
    
    var body: some View {
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
