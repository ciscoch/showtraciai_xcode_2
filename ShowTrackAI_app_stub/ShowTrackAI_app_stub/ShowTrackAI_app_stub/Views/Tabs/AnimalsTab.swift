import SwiftUI

struct AnimalsTab: View {
    @EnvironmentObject private var store: AnimalStore
    @State private var showAdd = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.animals) { animal in
                    VStack(alignment: .leading) {
                        Text(animal.name).font(.headline)
                        Text(animal.breed)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .onDelete { store.animals.remove(atOffsets: $0) }
            }
            .navigationTitle("Animals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAdd.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddAnimalSheet { newAnimal in
                    store.animals.append(newAnimal)
                }
            }
        }
    }
}

// MARK: - Add Animal Sheet
private struct AddAnimalSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var breed = ""
    
    var onSave: (Animal) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Breed", text: $breed)
            }
            .navigationTitle("Add Animal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(.init(name: name, breed: breed))
                        dismiss()
                    }
                    .disabled(name.isEmpty || breed.isEmpty)
                }
            }
        }
    }
}
