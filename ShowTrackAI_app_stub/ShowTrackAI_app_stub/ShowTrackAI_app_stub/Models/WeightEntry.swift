import Foundation
import SwiftUI

struct WeightEntry: Identifiable, Hashable, Codable {
    let id: UUID
    var date: Date
    var weight: Double
    var animalName: String          // NEW
    
    // Not persisted
    var progressPhoto: UIImage? = nil
    
    enum CodingKeys: String, CodingKey {
        case id, date, weight, animalName
    }
    
    init(id: UUID = UUID(),
         date: Date,
         weight: Double,
         animalName: String,
         progressPhoto: UIImage? = nil) {
        self.id = id
        self.date = date
        self.weight = weight
        self.animalName = animalName
        self.progressPhoto = progressPhoto
    }
}
