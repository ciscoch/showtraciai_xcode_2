//
//  Species.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import Foundation

/// Species list with predefined breeds.
enum Species: String, CaseIterable, Identifiable {
    case cattle  = "Cattle"
    case pig     = "Pig"
    case goat    = "Goat"
    case lamb    = "Lamb"
    
    var id: String { rawValue }
    
    /// Breeds available for each species.
    var breeds: [String] {
        switch self {
        case .cattle:
            return ["Angus", "Hereford", "Simmental"]
        case .pig:
            return ["Berkshire", "Chester White", "Duroc", "Hampshire", "Landrace",
                    "Poland China", "Spotted", "Yorkshire"]
        case .goat:
            return ["Boer", "Kiko", "Spanish", "Myotonic"]
        case .lamb:
            return ["Dorset", "Hamphsire", "Oxford", "Shropshire", "Suffolk",
                    "Crossbreds", "Katahdin", "Dorper"]
        }
    }
}
