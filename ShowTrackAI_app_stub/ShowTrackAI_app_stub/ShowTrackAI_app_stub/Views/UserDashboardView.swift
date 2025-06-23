//
//  UserDashboardView.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI

struct UserDashboardView: View {
    // Sheet toggles
    @State private var showExpenseSheet = false
    @State private var showAnimalSheet  = false
    @State private var showJournalSheet = false
    @State private var showWeightSheet  = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        showExpenseSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Expense")
                        }
                    }
                    
                    Button {
                        showAnimalSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Animal")
                        }
                    }
                    
                    Button {
                        showJournalSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Journal")
                        }
                    }
                    
                    Button {
                        showWeightSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Weight")
                        }
                    }
                }
            }
            .navigationTitle("User Dashboard")
            // Expense Sheet
            .sheet(isPresented: $showExpenseSheet) {
                ExpensesTab()   // or AddExpenseSheet if you prefer
            }
            // Animal Sheet
            .sheet(isPresented: $showAnimalSheet) {
                AnimalFormView(vm: .init())   // create new animal
                    .environmentObject(AnimalStore())
            }
            // Journal Sheet
            .sheet(isPresented: $showJournalSheet) {
                JournalFormView(vm: .init())
                    .environmentObject(JournalStore())
            }
            // Weight Sheet
            .sheet(isPresented: $showWeightSheet) {
                WeightTrackerTab()
            }
        }
    }
}

#Preview {
    UserDashboardView()
}
