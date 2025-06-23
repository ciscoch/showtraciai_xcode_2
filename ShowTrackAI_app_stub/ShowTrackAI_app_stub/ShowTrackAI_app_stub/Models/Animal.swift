//
//  Animal.swift
//  YourApp
//
//  Created by You on 2025-06-21.
//

import Foundation

struct Animal: Identifiable, Equatable, Codable {
    var id: UUID = UUID()
    
    // Core fields
    var name: String
    var species: String = ""
    var breed: String = ""
    var gender: String = ""
    var birthDate: Date = Date()
    var weight: Double = 0
    
    // Additional fields (placeholders for future use)
    var breederName: String = ""
    var aiScore: Int = 0
    var image: String = ""      // URL or local path
    var description: String = ""
    var showAnimal: Bool = true
    var purpose: String = ""
    var penNumber: String = ""
    var pickUpDate: Date = Date()
    var tagId: String = ""
    var organizationId: UUID?
    var status: String = ""
    var isPrivate: Bool = false
    var notes: String = ""
}
