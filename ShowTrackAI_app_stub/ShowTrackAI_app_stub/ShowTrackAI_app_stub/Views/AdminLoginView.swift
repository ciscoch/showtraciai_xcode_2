//
//  AdminLoginView.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import SwiftUI
import Supabase

struct AdminLoginView: View {
    @EnvironmentObject private var auth: AdminAuthStore
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Admin Login")) {
                    TextField("Username", text: $username)
                        .textContentType(.username)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                }
                
                Button("Login") {
                    auth.login(username: username, password: password)
                }
                .alert("Invalid credentials", isPresented: Binding(
                    get: { auth.errorMessage != nil },
                    set: { _ in auth.errorMessage = nil }
                )) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(auth.errorMessage ?? "")
                }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle("Admin")
            .alert("Invalid credentials", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            }
        }
    }

#Preview {
    AdminLoginView()
        .environmentObject(AdminAuthStore())
}
