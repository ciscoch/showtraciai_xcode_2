//  JournalCategory.swift
//  ShowTrackAI
//
//  Created by You on 2025‑06‑21.
//  Updated: Adds parentCategory, displayName, and auto‑derived subcategories.

import Foundation

// MARK: - Journal Subcategories
enum JournalSubcategory: String, CaseIterable, Identifiable, Codable {
    
    // Animal Handling
    case showmanship          = "Showmanship"
    case exercise             = "Exercise"
    
    // Animal Health
    case vaccinations         = "Vaccinations"
    case deworming            = "Deworming"
    case medicalEval          = "Medical Eval"
    
    // Nutrition & Facilities
    case feed                 = "Feed"
    case shavingsReplaced     = "Shavings Replaced"
    
    // FFA Activity
    case camp                 = "Camp"
    case conference           = "Conference"
    case convention           = "Convention"
    case courtesyCorps        = "Courtesy Corps"
    case ffaAwardInterview    = "FFA Award/Proficiency Interview"
    case ffaBandOrChorus      = "FFA Band or Chorus"
    case ffaTalent            = "FFA Talent"
    case leadershipAndService = "Leadership and Service"
    case meeting              = "Meeting"
    case otherActivity        = "Other"
    case projectShow          = "Project Show or Stock Show"
    case speech               = "Speech"
    case studentAwards        = "Student Awards"
    case workshop             = "Workshop"
    
    // MARK: - Identifiable
    var id: String { rawValue }
    
    // MARK: - Convenience
    /// Human‑readable label (useful if you later localize)
    var displayName: String { rawValue }
    
    /// The top‑level category this subcategory belongs to
    var parentCategory: JournalCategory {
        switch self {
        // Animal Handling
        case .showmanship, .exercise:
            return .animalHandling
            
        // Animal Health
        case .vaccinations, .deworming, .medicalEval:
            return .animalHealth
            
        // Nutrition & Facilities
        case .feed, .shavingsReplaced:
            return .nutritionFacilities
            
        // FFA Activity
        default:
            return .ffaActivity
        }
    }
}

// MARK: - Journal Categories
enum JournalCategory: String, CaseIterable, Identifiable, Codable {
    case animalHandling       = "Animal Handling"
    case animalHealth         = "Animal Health"
    case nutritionFacilities  = "Nutrition & Facilities"
    case ffaActivity          = "FFA Activity"
    
    // MARK: - Identifiable
    var id: String { rawValue }
    
    // MARK: - Convenience
    /// All subcategories that belong to this category
    var subcategories: [JournalSubcategory] {
        JournalSubcategory.allCases.filter { $0.parentCategory == self }
    }
    
    /// Human‑readable label (mirrors `rawValue`, handy for future localization)
    var displayName: String { rawValue }
    
    /// Quick lookup helper
    static func category(for subcategory: JournalSubcategory) -> JournalCategory {
        subcategory.parentCategory
    }
}
