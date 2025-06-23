//
//  Expense.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import Foundation
import UIKit   // for UIImage

struct Expense: Identifiable {
    var id: UUID = UUID()
    var category: String
    var amount: Double
    var date: Date = Date()          // NEW
    // UIImage isn’t Codable; store path or Data if you persist
    var receiptImage: UIImage? = nil
}

