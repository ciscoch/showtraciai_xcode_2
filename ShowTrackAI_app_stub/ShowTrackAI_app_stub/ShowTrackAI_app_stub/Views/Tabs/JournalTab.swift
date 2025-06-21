import SwiftUI
import PhotosUI

struct JournalTab: View {
    
    @State private var entries: [JournalEntry] = []
    @State private var showAdd = false
    
    private var isElite: Bool { SupabaseManager.shared.role == "elite" }
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }
    
    var body: some View {
        NavigationStack {
            List {
                if !isElite {
                    UpgradeBanner()
                        .listRowInsets(EdgeInsets())
                }
                
                ForEach(entries) { entry in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(dateFormatter.string(from: entry.date))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(entry.activity)
                        
                        if isElite {
                            if let type = entry.type { Text("Type: \(type)").font(.caption) }
                            if let level = entry.level { Text("Level: \(level)").font(.caption) }
                            if let hrs = entry.hours {
                                Text(String(format: "Hours: %.1f", hrs))
                                    .font(.caption)
                            }
                            if entry.receiptImage != nil {
                                Image(systemName: "photo")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete { entries.remove(atOffsets: $0) }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAdd.toggle()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "plus")
                            Text("New Entry")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                if isElite {
                    AddEliteEntrySheet { entries.append($0) }
                } else {
                    AddUserEntrySheet { entries.append($0) }
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
            Text("Unlock Type, Level, Description, Time In/Out, Hour Counter, and Receipt Photos.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Button("Upgrade Now") {
                SupabaseManager.shared.role = "elite"
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.orange.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

// MARK: - Simple User Sheet
private struct AddUserEntrySheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var date = Date()
    @State private var activity = ""
    var onSave: (JournalEntry) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Activity", text: $activity)
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(.init(date: date, activity: activity))
                        dismiss()
                    }
                    .disabled(activity.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

// MARK: - Elite Sheet
private struct AddEliteEntrySheet: View {
    @Environment(\.dismiss) private var dismiss
    
    private let types = [
        "Camp", "Conference", "Convention", "Courtesy Corps",
        "FFA Award/Proficiency Interview", "FFA Band or Chorus",
        "FFA Talent", "Leadership and Service", "Meeting", "Other",
        "Project Show or Stock Show", "Speech", "Student Awards", "Workshop"
    ]
    
    @State private var date = Date()
    @State private var activity = ""
    @State private var selectedType = "Camp"
    @State private var level = ""
    @State private var detail = ""
    @State private var timeIn = Date()
    @State private var timeOut = Date()
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var receiptImage: UIImage?
    
    var onSave: (JournalEntry) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Activity", text: $activity)
                
                Picker("Type", selection: $selectedType) {
                    ForEach(types, id: \.self) { Text($0) }
                }
                
                TextField("Level", text: $level)
                TextEditor(text: $detail)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray.opacity(0.3)))
                    .padding(.vertical, 4)
                
                DatePicker("Time In", selection: $timeIn, displayedComponents: .hourAndMinute)
                DatePicker("Time Out", selection: $timeOut, displayedComponents: .hourAndMinute)
                
                Section("Picture") {
                    PhotosPicker("Select Photo", selection: $selectedPhoto, matching: .images)
                    
                    if let img = receiptImage {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(
                            JournalEntry(
                                date: date,
                                activity: activity,
                                type: selectedType,
                                level: level,
                                detail: detail,
                                timeIn: timeIn,
                                timeOut: timeOut,
                                receiptImage: receiptImage
                            )
                        )
                        dismiss()
                    }
                    .disabled(activity.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onChange(of: selectedPhoto) { newItem in
                guard let newItem else { return }
                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        receiptImage = uiImage
                    }
                }
            }
        }
    }
}
