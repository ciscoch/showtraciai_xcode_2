//
//  AnimalsTab.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI

struct AnimalsTab: View {
    @EnvironmentObject private var store: AnimalStore
    
    @State private var showAddSheet = false
    @State private var selectedAnimal: Animal?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.animals) { animal in
                    Button {
                        selectedAnimal = animal
                    } label: {
                        HStack {
                            Text(animal.name)
                            Spacer()
                            Text(animal.species)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete { offsets in
                    store.delete(at: offsets)
                }
            }
            .navigationTitle("Animals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        HStack(spacing: 4) {
                            Text("New Animal")
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            // Add sheet
            .sheet(isPresented: $showAddSheet) {
                NavigationStack {
                    AnimalFormView(vm: .init())          // create new
                        .environmentObject(store)
                }
            }
            // Edit sheet
            .sheet(item: $selectedAnimal) { animal in
                NavigationStack {
                    AnimalFormView(vm: .init(animal: animal)) // edit existing
                        .environmentObject(store)
                }
            }
        }
    }
}

#Preview {
    AnimalsTab()
        .environmentObject(AnimalStore())
}
