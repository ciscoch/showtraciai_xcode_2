//
//  Binding+Optional.swift
//  YourApp
//
//  Created by You on 2025-06-21.
//

import SwiftUI

extension Binding where Value == String {
    /// Returns a Binding<String> that trims whitespace on set.
    func trimming() -> Binding<String> {
        Binding<String>(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        )
    }
}

extension Binding where Value == Double {
    /// Converts Double to String and back for TextField convenience.
    func asString() -> Binding<String> {
        Binding<String>(
            get: { String(wrappedValue) },
            set: { wrappedValue = Double($0) ?? 0 }
        )
    }
}//
//  Binding+Optional.swift
//  ShowTrackAI_app_stub
//
//  Created by Francisco Charles on 6/21/25.
//

import Foundation
