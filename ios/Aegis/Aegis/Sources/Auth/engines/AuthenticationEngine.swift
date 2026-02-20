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
    
    let supabase = SupabaseClient(
        supabaseURL: URL(string: Bundle.main.infoDictionary?["SUPABASE_URL"] as? String ?? "")!,
        supabaseKey: Bundle.main.infoDictionary?["SUPABASE_KEY"] as? String ?? ""
    )
    
    func getAuthenticatedUser() async throws -> AuthDataResultModel {
        guard let user = try? await supabase.auth.user() else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() async throws {
        try await supabase.auth.signOut()
    }
}

extension AuthenticationEngine {
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await supabase.auth.signUp(email: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await supabase.auth.signIn(email: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
