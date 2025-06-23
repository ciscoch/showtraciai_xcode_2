//  JournalFormView.swift
//  ShowTrackAI
//
//  Created by You on 2025‑06‑21.
//  Updated: Fixes Section initializer order.

import SwiftUI
import Supabase

struct JournalFormView: View {
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: JournalStore
    
    // MARK: - ViewModel
    @StateObject var vm: JournalFormVM
    
    // Local UI state mirrors entry
    @State private var category: JournalCategory
    @State private var subcategory: JournalSubcategory
    
    // MARK: - Init
    init(vm: JournalFormVM) {
        _vm          = StateObject(wrappedValue: vm)
        _category    = State(initialValue: vm.entry.category)
        _subcategory = State(initialValue: vm.entry.subcategory)
    }
    
    // MARK: - Body
    var body: some View {
        Form {
            // MARK: Category
            Section(
                content: {
                    Picker("Main", selection: $category) {
                        ForEach(JournalCategory.allCases) { cat in
                            Text(cat.displayName).tag(cat)
                        }
                    }
                    .onChange(of: category) { newValue in
                        vm.entry.category = newValue
                        if !newValue.subcategories.contains(subcategory) {
                            subcategory = newValue.subcategories.first!
                            vm.entry.subcategory = subcategory
                        }
                    }
                    
                    Picker("Sub‑Category", selection: $subcategory) {
                        ForEach(category.subcategories) { sub in
                            Text(sub.displayName).tag(sub)
                        }
                    }
                    .onChange(of: subcategory) { newValue in
                        vm.entry.subcategory = newValue
                    }
                },
                header: {
                    Text("Category")
                }
            )
            
            // MARK: Feed Details
            if subcategory == .feed {
                Section(
                    content: {
                        TextField(
                            "Feed Brand & Name",
                            text: Binding(
                                get: { vm.entry.feedBrand ?? "" },
                                set: { vm.entry.feedBrand = $0.isEmpty ? nil : $0 }
                            )
                        )
                        
                        TextField("Lbs of Feed",
                                  value: $vm.entry.lbsOfFeed,
                                  format: .number)
                        .keyboardType(.decimalPad)
                        
                        Toggle("Hay Included", isOn: $vm.entry.hayIncluded)
                        Toggle("Pen Cleaning", isOn: $vm.entry.penCleaning)
                    },
                    header: {
                        Text("Feed Details")
                    }
                )
                
                // Nutrient Focus
                Section(
                    content: {
                        VStack(alignment: .leading, spacing: 8) {
                            Toggle("Protein", isOn: $vm.entry.focusProtein)
                            Text("Essential for muscle development and growth.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        // … (other nutrient toggles)
                    },
                    header: {
                        Text("Nutrient Focus")
                    }
                )
            }
            
            // MARK: Notes
            Section(
                content: {
                    TextEditor(text: $vm.entry.notes)
                        .frame(minHeight: 80)
                },
                header: {
                    Text("Notes")
                }
            )
            
            // MARK: - Preview
            #Preview {
                NavigationStack {
                    JournalFormView(vm: .init())
                        .environmentObject(JournalStore())
                }
            }
        }
    }
}
