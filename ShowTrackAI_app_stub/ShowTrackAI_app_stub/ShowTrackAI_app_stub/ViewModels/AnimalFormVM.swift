//
//  AnimalFormVM.swift
//  YourApp
//
//  Created by You on 2025-06-21.
//

import Foundation
import SwiftUI

final class AnimalFormVM: ObservableObject {
    @Published var animal: Animal
    @Environment(\.dismiss) private var dismiss
    
    init(animal: Animal = Animal(name: "")) {
        self.animal = animal
    }
    
    var isNew: Bool {
        !animalExists
    }
    
    private var animalExists: Bool {
        // If the ID is not unique in store, treat as existing.
        // In-memory, we can’t check easily here; handled in caller.
        false
    }
}
