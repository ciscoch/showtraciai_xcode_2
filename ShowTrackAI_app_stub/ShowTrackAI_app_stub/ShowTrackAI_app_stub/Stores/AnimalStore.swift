//
//  AnimalStore.swift
//  YourApp
//
//  Created by You on 2025-06-21.
//

import Foundation
import Combine

/// Simple in‑memory store. Replace with database logic later.
final class AnimalStore: ObservableObject {
    @Published private(set) var animals: [Animal] = []
    
    // MARK: - CRUD
    
    func add(_ animal: Animal) {
        animals.append(animal)
    }
    
    func update(_ animal: Animal) {
        guard let index = animals.firstIndex(where: { $0.id == animal.id }) else { return }
        animals[index] = animal
    }
    
    func delete(at offsets: IndexSet) {
        animals.remove(atOffsets: offsets)
    }
}
