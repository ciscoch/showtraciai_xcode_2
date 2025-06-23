//
//  JournalEntry.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import Foundation

struct JournalEntry: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date = Date()
    
    var category: JournalCategory
    var subcategory: JournalSubcategory
    
    // Animal Handling
    var timeIn: Date?
    var timeOut: Date?
    
    // Nutrition (Feed)
    var feedBrand: String?          // NEW
    var lbsOfFeed: Double?
    var hayIncluded: Bool = false
    
    // Nutrient Focus (Feed)  NEW
    var focusProtein: Bool = false
    var focusEnergy: Bool = false
    var focusVitaminsMinerals: Bool = false
    var focusFiber: Bool = false
    
    // Notes
    var notes: String = ""
    
    /// Computed total minutes between in/out (Animal Handling)
    var totalMinutes: Int? {
        guard let start = timeIn, let end = timeOut else { return nil }
        return Int(end.timeIntervalSince(start) / 60)
    }
}
