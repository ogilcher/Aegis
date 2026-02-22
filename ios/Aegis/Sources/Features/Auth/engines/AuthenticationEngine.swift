//
//  AuthenticationEngine.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import Foundation
import Supabase

struct AuthDataResultModel {
    let uid: UUID
    let email: String?
    
    init(user: User) {
        self.uid = user.id
        self.email = user.email
    }
}

@MainActor
final class AuthenticationEngine {
    
    private let db: SupabaseClient
    let redirectTo = URL(string: "aegis://auth-callback")!
    
    init(db: SupabaseClient) {
        self.db = db
    }
    
    @MainActor convenience init() {
        self.init(db: Supabase.client)
    }
    
    func getAuthenticatedUser() async throws -> AuthDataResultModel {
        guard let user = try? await db.auth.user() else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() async throws {
        try await db.auth.signOut()
    }
}

extension AuthenticationEngine {
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await db.auth.signUp(email: email, password: password, redirectTo: redirectTo)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await db.auth.signIn(email: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
}

