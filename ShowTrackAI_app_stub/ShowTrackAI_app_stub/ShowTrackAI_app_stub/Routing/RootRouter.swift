import SwiftUI
import Combine

final class RootRouter: ObservableObject {
    
    enum Screen {
        case login
        case userDash
        case eliteDash
        case buyerDash
    }
    
    @Published var current: Screen = .login
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = SupabaseManager.shared.$role
            .sink { [weak self] role in
                guard !role.isEmpty else {
                    self?.current = .login
                    return
                }
                switch role {
                case "elite":  self?.current = .eliteDash
                case "buyer":  self?.current = .buyerDash
                default:       self?.current = .userDash
                }
            }
    }
}
