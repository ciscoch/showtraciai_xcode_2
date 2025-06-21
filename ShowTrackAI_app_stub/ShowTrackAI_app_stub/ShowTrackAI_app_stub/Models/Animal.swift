//
//  Animal.swift
//  ShowTrackAI_app_stub
//
//  Created by Francisco Charles on 6/21/25.
//

import Foundation

struct Animal: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var breed: String
}
