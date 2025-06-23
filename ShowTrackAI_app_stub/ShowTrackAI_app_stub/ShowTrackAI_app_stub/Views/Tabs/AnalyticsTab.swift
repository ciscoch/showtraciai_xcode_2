//
//  AnalyticsTab.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI

struct AnalyticsTab: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("User Statistics") {
                    Text("User stats coming soon…")
                }
                NavigationLink("Activity Logs") {
                    Text("Activity logs coming soon…")
                }
                NavigationLink("Feed Analytics") {
                    Text("Feed analytics coming soon…")
                }
                NavigationLink("Bug Reports") {
                    Text("Bug reports coming soon…")
                }
            }
            .navigationTitle("Analytics")
        }
    }
}

#Preview {
    AnalyticsTab()
}
