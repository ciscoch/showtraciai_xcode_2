//
//  AnimalFormView.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI

struct AnimalFormView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: AnimalStore
    
    @StateObject var vm: AnimalFormVM
    @State private var selectedSpecies: Species = .cattle
    
    var body: some View {
        Form {
            // MARK: Basic
            Section(header: Text("Basic Info")) {
                TextField("Name", text: $vm.animal.name.trimming())
                    .autocapitalization(.words)
                
                // Species
                Picker("Species", selection: $selectedSpecies) {
                    ForEach(Species.allCases) { species in
                        Text(species.rawValue).tag(species)
                    }
                }
                .onChange(of: selectedSpecies) { newValue in
                    vm.animal.species = newValue.rawValue
                    if !newValue.breeds.contains(vm.animal.breed) {
                        vm.animal.breed = ""
                    }
                }
                
                // Breed
                Picker("Breed", selection: $vm.animal.breed) {
                    ForEach(selectedSpecies.breeds, id: \.self) { breed in
                        Text(breed).tag(breed)
                    }
                }
                
                // Breeder
                TextField("Breeder", text: $vm.animal.breederName.trimming())
                
                // Pen #
                TextField("Pen #", text: $vm.animal.penNumber.trimming())
                    .keyboardType(.numbersAndPunctuation)
            }
            
            // MARK: Dates
            Section(header: Text("Dates")) {
                DatePicker("Birth Date", selection: $vm.animal.birthDate, displayedComponents: .date)
                DatePicker("Pick‑Up Date", selection: $vm.animal.pickUpDate, displayedComponents: .date)
            }
            
            // MARK: Weight
            Section(header: Text("Weight (lbs)")) {
                TextField("Weight", text: $vm.animal.weight.asString())
                    .keyboardType(.decimalPad)
            }
            
            // MARK: Visibility
            Section(header: Text("Visibility")) {
                Toggle("Show Animal", isOn: $vm.animal.showAnimal)
                Toggle("Private", isOn: $vm.animal.isPrivate)
            }
            
            // MARK: Notes
            Section(header: Text("Notes")) {
                TextEditor(text: $vm.animal.notes)
                    .frame(minHeight: 80)
            }
        }
        .navigationTitle(vm.isNew ? "Add Animal" : "Edit Animal")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if vm.isNew {
                        store.add(vm.animal)
                    } else {
                        store.update(vm.animal)
                    }
                    dismiss()
                }
                .disabled(vm.animal.name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .onAppear {
            // Sync initial species
            if let species = Species(rawValue: vm.animal.species) {
                selectedSpecies = species
            } else {
                selectedSpecies = .cattle
                vm.animal.species = selectedSpecies.rawValue
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnimalFormView(vm: .init())
            .environmentObject(AnimalStore())
    }
}
