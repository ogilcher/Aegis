//
//  AppCoordinator.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import SwiftUI
import Combine

// MARK: - App Coordinator

@MainActor
final class AppCoordinator: ObservableObject {
    
    // MARK: - Dependencies
    
    var authEngine: AuthenticationEngine?
    var security: SecurityServices?
    
    // MARK: - Navigation state
    
    @Published var root: AppScreen = .root
    @Published var path: [AppScreen] = []
    
    // MARK: - Session state
    
    @Published var isAuthenticated = false
    @Published var user: DBUser?
    
    // MARK: - ViewModels
    
    @Published var authViewModel: AuthViewModel?
    @Published var healthViewModel: HealthViewModel?
    
    // MARK: - Derived state
    // ...
    
    // MARK: - Bootstrap guards
    
    private var isApplyingGate = false
    private var didBootstrap = false
    
    init() {}
    
    // MARK: - Main Bootstrap
    
    @MainActor
    func bootstrapSession() async {
        // Skip full bootstrap if this is running inside SwiftUI Previews
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            print("bootstrap: running in Previews - skipping session bootstrap")
            lpUpdateWithoutAnimation {
                self.isAuthenticated = false
                self.user = nil
                self.authViewModel = nil
                
                self.goToRoot(.root)
            }
            return
        }
        
        guard !didBootstrap else { return }
        didBootstrap = true
        
        // MARK: - Security boostrap (E2EE foundation)
        
        do {
            let config = SecurityBootstrap.Config(keyProtection: .userPresenceThisDeviceOnly)
            self.security = try SecurityBootstrap.build(config: config)
            print("bootstrap: security ready -> userId=\(self.security?.userId ?? "nil")")
        } catch {
            // If security bootstrap fails, treat it as a fatal for E2EE
            print("bootstrap: security bootstrap failed: \(error)")
            
            lpUpdateWithoutAnimation {
                self.isAuthenticated = false
                self.user = nil
                self.authViewModel = nil
                self.goToRoot(.root)
            }
            return
        }
        
        // Starting bootstrap sequence
        print("bootstrap: starting...")
        self.authEngine = AuthenticationEngine()
        let authUser = try? await authEngine!.getAuthenticatedUser()
        print("bootstrap: auth snapshot -> \(authUser == nil ? "nil" : "exists")")
        
        await Task.yield()
        
        if let authUser {
            await bootstrapWithAuthenticatedUser(authUser)
        } else {
            lpUpdateWithoutAnimation {
                self.isAuthenticated = false
                self.user = nil
                
                authViewModel = AuthViewModel(engine: authEngine!)
            }
        }
        
        applyGate(using: authUser)
        print("bootstrap: finished -> root=\(root)")
    }
    
    private func bootstrapWithAuthenticatedUser(_ authUser: AuthDataResultModel) async {
//        do {
//
//            
//        } catch {
//            print("bootstrap: fetch user failed: \(error)")
//            
//            lpUpdateWithoutAnimation {
//                self.isAuthenticated = false
//                // ...
//                
//            }
//        }
    }
    
    // MARK: - Central Gate
    
    private func applyGate(using authUser: AuthDataResultModel?) {
        guard !isApplyingGate else { return }
        isApplyingGate = true
        defer { isApplyingGate = false }
        
        if !isAuthenticated {
            lpUpdateWithoutAnimation {
                self.goToRoot(.auth(.tosAgreement))
            }
            
            return
        }
        
        goHome()
    }
    
    // MARK: - Auth Flow
    
    func handleSignInSuccess() async {
        lpUpdateWithoutAnimation {
            self.isAuthenticated = true
        }
        let authUser = try? await authEngine?.getAuthenticatedUser()

        applyGate(using: authUser)
    }
    
    func handleAuthCallback(_ url: URL) {
        Task {
            do {
                try await Supabase().establishSession(url)
                self.isAuthenticated = true
                // TODO: Make this actually create a user object
                applyGate(using: nil)
            }
        }
    }
    
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

protocol SessionProviding {
    func getAuthenticatedUser() throws -> AuthDataResultModel
    func signOut() throws
}
