//
//  AccountMaintenanceTab.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI

struct AccountMaintenanceTab: View {
    // Replace with real data source later
    @State private var dummyUsers = ["user1@example.com", "user2@example.com"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dummyUsers, id: \.self) { user in
                    Text(user)
                }
            }
            .navigationTitle("Account Maintenance")
        }
    }
}

#Preview {
    AccountMaintenanceTab()
}
