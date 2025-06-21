import SwiftUI
import PhotosUI

struct ExpensesTab: View {
    
    private let categories = [
        "General Transfer/Barter",
        "Feed Expense",
        "Other Expense",
        "Veterinary Medicine",
        "Supplies",
        "Repairs/Maintenance",
        "Seed",
        "Fertilizer/Chemicals",
        "Rent",
        "Entry Fees/Commissions",
        "Inventory for Resale",
        "Fuel",
        "Contract/Custom",
        "Custom…"                    // triggers custom text field
    ]
    
    @State private var expenses: [Expense] = []
    @State private var showAdd = false
    
    // Currency formatter
    private var currencyFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }
    
    // Quick role check (stub)
    private var isElite: Bool {
        SupabaseManager.shared.role == "elite"
    }
    
    var body: some View {
        NavigationStack {
            List {
                // MARK: - Upgrade Banner
                if !isElite {
                    UpgradeBanner()
                        .listRowInsets(EdgeInsets())   // edge‑to‑edge
                }
                
                // MARK: - Expense rows
                ForEach(expenses) { exp in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(exp.category)
                            if exp.receiptImage != nil {
                                Image(systemName: "photo")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                        Text(currencyFormatter.string(from: NSNumber(value: exp.amount)) ?? "$0.00")
                    }
                }
                .onDelete { expenses.remove(atOffsets: $0) }
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAdd.toggle()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "plus")
                            Text("New Expense")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddExpenseSheet(categories: categories, allowPhoto: isElite) { newExpense in
                    expenses.append(newExpense)
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
            Text("Unlock receipt photos and more categories.")
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

// MARK: - Add Expense Sheet
private struct AddExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let categories: [String]
    let allowPhoto: Bool
    var onSave: (Expense) -> Void
    
    @State private var selectedCategory = "General Transfer/Barter"
    @State private var customCategory = ""
    @State private var amount = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var receiptImage: UIImage?
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { cat in
                        Text(cat).tag(cat)
                    }
                }
                
                if selectedCategory == "Custom…" {
                    TextField("Custom Category", text: $customCategory)
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                
                if allowPhoto {
                    Section("Receipt Photo") {
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
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let category = selectedCategory == "Custom…" ? customCategory : selectedCategory
                        let value = Double(amount) ?? 0.0
                        onSave(.init(category: category, amount: value, receiptImage: receiptImage))
                        dismiss()
                    }
                    .disabled(
                        (selectedCategory == "Custom…" && customCategory.isEmpty) ||
                        amount.isEmpty
                    )
                }
            }
            .onChange(of: selectedPhoto) { newItem in
                guard allowPhoto, let newItem else { return }
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
