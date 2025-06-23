//
//  AnimalListView.swift
//  ShowTrackAI_app_stub
//
//  Created by Francisco Charles on 6/21/25.
//

//
//  AnimalListView.swift
//  YourApp
//
//  Created by You on 2025-06-21.
//

import SwiftUI

struct AnimalListView: View {
    @StateObject private var store = AnimalStore()
    
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
                .onDelete(perform: store.delete)
            }
            .navigationTitle("My Animals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                NavigationStack {
                    AnimalFormView(vm: .init())
                        .environmentObject(store)
                }
            }
            .sheet(item: $selectedAnimal) { animal in
                NavigationStack {
                    AnimalFormView(vm: .init(animal: animal))
                        .environmentObject(store)
                }
            }
        }
    }
}

#Preview {
    AnimalListView()
}
