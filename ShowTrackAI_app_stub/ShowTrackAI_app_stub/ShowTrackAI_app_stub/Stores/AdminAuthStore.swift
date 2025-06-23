//
//  AdminAuthStore.swift
//  ShowTrackAI
//
//  Created by You on 2025-06-21.
//

import Foundation
import Combine

@MainActor
class class AdminAuthStore: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    
    // Hard‑coded credentials
    private let validUsername = "admin"
    private let validPassword = "password123"
    
    func login(username: String, password: String) {
        if username == validUsername && password == validPassword {
            isAuthenticated = true
            errorMessage = nil
        } else {
            errorMessage = "Invalid credentials."
        }
    }
    
    func logout() {
        isAuthenticated = false
    }
}
