//
//  JournalTab.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI

struct JournalTab: View {
    @EnvironmentObject private var store: JournalStore
    @State private var showAddSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.entries) { entry in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.subcategory.rawValue)
                            .font(.headline)
                        Text(entry.category.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(entry.date, style: .date)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        // Show total time if available
                        if let minutes = entry.totalMinutes {
                            Text("Total Time: \(minutes) min")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        
                        // Show feed info if available
                        if entry.subcategory == .feed {
                            if let lbs = entry.lbsOfFeed {
                                Text("Feed: \(lbs, specifier: "%.1f") lbs \(entry.hayIncluded ? "(Hay)" : "")")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: store.delete)
            }
            .navigationTitle("Elite Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        HStack(spacing: 4) {
                            Text("New Entry")
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                NavigationStack {
                    JournalFormView(vm: .init())
                        .environmentObject(store)
                }
            }
        }
    }
}

#Preview {
    JournalTab()
        .environmentObject(JournalStore())
}
