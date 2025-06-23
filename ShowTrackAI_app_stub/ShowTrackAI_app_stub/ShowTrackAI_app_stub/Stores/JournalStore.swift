//
//  JournalStore.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import Foundation
import Combine

final class JournalStore: ObservableObject {
    @Published private(set) var entries: [JournalEntry] = []
    
    func add(_ entry: JournalEntry) {
        entries.append(entry)
    }
    
    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
}
