import SwiftUI

struct WatchlistTab: View {
    @State private var items: [WatchlistItem] = [
        .init(name: "Bella", breed: "Angus"),
        .init(name: "Max",   breed: "Hereford")
    ]
    @State private var showAdd = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    VStack(alignment: .leading) {
                        Text(item.name).font(.headline)
                        Text(item.breed)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .onDelete { items.remove(atOffsets: $0) }
            }
            .navigationTitle("Watchlist")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showAdd.toggle() } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddWatchlistItemSheet { newItem in
                    items.append(newItem)
                }
            }
        }
    }
}

// MARK: - Add Sheet
private struct AddWatchlistItemSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var breed = ""
    
    var onSave: (WatchlistItem) -> Void
    
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
