import Foundation
import SwiftUI   // for UIImage

struct Expense: Identifiable, Hashable {
    let id = UUID()
    var category: String
    var amount: Double
    var receiptImage: UIImage? = nil   // optional receipt photo
}
