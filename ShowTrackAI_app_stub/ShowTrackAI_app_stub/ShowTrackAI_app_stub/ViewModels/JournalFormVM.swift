//
//  JournalFormVM.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import Foundation

final class JournalFormVM: ObservableObject {
    @Published var entry: JournalEntry
    
    init(entry: JournalEntry = JournalEntry(category: .animalHandling,
                                            subcategory: .showmanship)) {
        self.entry = entry
    }
}
