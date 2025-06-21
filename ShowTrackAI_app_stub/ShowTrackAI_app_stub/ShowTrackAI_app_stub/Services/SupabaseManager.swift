import Foundation
import Combine

final class SupabaseManager: ObservableObject {
    static let shared = SupabaseManager()
    
    /// Empty means “not signed in”
    @Published var role: String = ""      // "", "free", "elite", "buyer"
    
    private init() {}
}
