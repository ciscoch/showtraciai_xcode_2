import SwiftUI
import Charts
import PhotosUI

// MARK: - Persistence helper
private struct WeightStore {
    static let key = "weight_entries"
    static func load() -> [WeightEntry] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode([WeightEntry].self, from: data)
        else { return [] }
        return decoded
    }
    static func save(_ entries: [WeightEntry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

struct WeightTrackerTab: View {
    @EnvironmentObject private var animalStore: AnimalStore   // NEW
    
    @State private var weights: [WeightEntry] = WeightStore.load()
    @State private var showAdd = false
    
    private var isElite: Bool { SupabaseManager.shared.role == "elite" }
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .short
        return df
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if !isElite { UpgradeBanner().padding(.horizontal) }
                if isElite && !weights.isEmpty {
                    Chart(weights) {
                        LineMark(
                            x: .value("Date", $0.date),
                            y: .value("Weight", $0.weight)
                        )
                    }
                    .frame(height: 220)
                    .padding(.horizontal)
                }
                List {
                    ForEach(weights) { entry in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(entry.animalName) – \(dateFormatter.string(from: entry.date))")
                                Text("\(entry.weight, specifier: "%.1f") lbs")
                                    .font(.subheadline)
                            }
                            Spacer()
                            if isElite, entry.progressPhoto != nil {
                                Image(systemName: "photo")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete { idx in
                        weights.remove(atOffsets: idx)
                        WeightStore.save(weights)
                    }
                }
            }
            .navigationTitle("Weights")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showAdd.toggle() } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "plus")
                            Text("New Weight")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddWeightSheet(
                    animals: animalStore.animals.map(\.name),   // NEW
                    allowPhoto: isElite
                ) { newEntry in
                    weights.append(newEntry)
                    WeightStore.save(weights)
                }
            }
        }
    }
}

// MARK: - Upgrade Banner
private struct UpgradeBanner: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("Upgrade to Elite")
                .font(.headline)
            Text("Unlock growth charts, progress photos, AI predictions, and sharing to Storyboard.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Button("Upgrade Now") {
                SupabaseManager.shared.role = "elite"
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.vertical, 8)
    }
}
// MARK: - Add Sheet
private struct AddWeightSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let animals: [String]
    let allowPhoto: Bool
    var onSave: (WeightEntry) -> Void
    
    @State private var selectedAnimal = ""
    @State private var date = Date()
    @State private var weight = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var progressImage: UIImage?
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Animal", selection: $selectedAnimal) {
                    ForEach(animals, id: \.self) { Text($0) }
                }
                
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Weight (lbs)", text: $weight)
                    .keyboardType(.decimalPad)
                
                if allowPhoto {
                    Section("Progress Photo") {
                        PhotosPicker("Select Photo", selection: $selectedPhoto, matching: .images)
                        if let img = progressImage {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }
            .navigationTitle("Add Weight")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let value = Double(weight) ?? 0
                        onSave(.init(
                            date: date,
                            weight: value,
                            animalName: selectedAnimal.isEmpty ? animals.first ?? "Unknown" : selectedAnimal,
                            progressPhoto: progressImage
                        ))
                        dismiss()
                    }
                    .disabled(weight.isEmpty || animals.isEmpty)
                }
            }
            .onAppear { selectedAnimal = animals.first ?? "" }
            .onChange(of: selectedPhoto) { newItem in
                guard allowPhoto, let newItem else { return }
                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        progressImage = uiImage
                    }
                }
            }
        }
    }
}
