//
//  JournalEntry.swift
//  ShowTrackAI_app_stub
//
//  Created by Francisco Charles on 6/21/25.
//

import Foundation
import SwiftUI   // for UIImage

struct JournalEntry: Identifiable, Hashable {
    let id = UUID()
    var date: Date
    var activity: String
    
    // Elite‑only fields
    var type: String? = nil
    var level: String? = nil
    var detail: String? = nil
    var timeIn: Date? = nil
    var timeOut: Date? = nil
    var receiptImage: UIImage? = nil
    
    /// Computed hours (Elite)
    var hours: Double? {
        guard let start = timeIn, let end = timeOut else { return nil }
        return end.timeIntervalSince(start) / 3600
    }
}
