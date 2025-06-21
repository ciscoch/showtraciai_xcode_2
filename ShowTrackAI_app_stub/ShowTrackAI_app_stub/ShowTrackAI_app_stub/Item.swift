//
//  Item.swift
//  ShowTrackAI_app_stub
//
//  Created by Francisco Charles on 6/21/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
