//
//  AppCoordinator.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import SwiftUI
import Combine

// MARK: - App Screen

enum AppScreen: Hashable {
    
    // Auth
    case tosAgreement
    case signIn
    case signUp
    
    // Main root
    case root
    case home
    
    // TODO: Category Routing
}

// MARK: - Helpers

private extension Transaction {
    static var noAnimation: Transaction {
        Transaction(animation: nil)
    }
}

@MainActor
private func lpUpdateWithoutAnimation(_ body: () -> Void) {
    withTransaction(.noAnimation, body)
}

// MARK: - App Coordinator

@MainActor
final class AppCoordinator: ObservableObject {
    
    // MARK: - Dependencies
    let authEngine: AuthenticationEngine = .init()
    
    // MARK: - Navigation state
    @Published var root: AppScreen = .root
    @Published var path: [AppScreen] = []
    
    // MARK: - Session state
    
    @Published var isAuthenticated = false
    // TODO: Get current user
    
    // MARK: - ViewModels
    // ...
    
    // MARK: - Derived state
    // ...
    
    // MARK: - Bootstrap guards
    
    private var isApplyingGate = false
    private var didBootstrap = false
    
    // MARK: - Init
    
    init() {}
    
    @MainActor
    func bootstrapSession() async {
        // Skil full bootstrap if this is running inside SwiftUI Previews
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            print("bootstrap: running in Previews - skipping session bootstrap")
            lpUpdateWithoutAnimation {
                self.isAuthenticated = false
                self.didBootstrap = true
                
                self.goToRoot(.root)
            }
            return
        }
        
        guard !didBootstrap else { return }
        didBootstrap = true
        
        print("bootstrap: starting...")
        
        let authUser = try? await authEngine.getAuthenticatedUser()
        print("bootstrap: auth snapshot -> \(authUser == nil ? "nil" : "exists")")
        
        await Task.yield()
        
        if let authUser {
            await bootstrapWithAuthenticatedUser(authUser)
        } else {
            lpUpdateWithoutAnimation {
                self.isAuthenticated = false
                // ...
            }
        }
        
        applyGate(using: authUser)
        print("bootstrap: finished -> root=\(root)")
    }
    
    private func bootstrapWithAuthenticatedUser(_ authUser: AuthDataResultModel) async {
        do {
            // Get DB User (seperate from auth)
            // ...
            
        } catch {
            print("bootstrap: fetch user failed: \(error)")
            
            lpUpdateWithoutAnimation {
                self.isAuthenticated = false
                // ...
                
            }
        }
    }
    
    // MARK: - Central Gate
    
    private func applyGate(using authUser: AuthDataResultModel?) {
        guard !isApplyingGate else { return }
        isApplyingGate = true
        defer { isApplyingGate = false }
        
        if !isAuthenticated {
            lpUpdateWithoutAnimation {
                self.goToRoot(.tosAgreement)
            }
            
            return
        }
        
        goHome()
    }
    
    // MARK: - Main Navigation
    
    // MARK: - Logout & Utilities
    
    // MARK: - Navigation Helpers
    
    func goHome() {
        goToRoot(.home)
    }
    
    func goToRoot(_ screen: AppScreen) {
        root = screen
        path.removeAll()
    }
    
    func push(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func pop() {
        _ = path.popLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
