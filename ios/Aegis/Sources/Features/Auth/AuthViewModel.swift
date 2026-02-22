//
//  AuthViewModel.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import Foundation
import Combine

enum FieldError: Hashable { case email, password }
enum AuthError: Error, Equatable { case invalidForm, emailInUse, noAccountFound, other }

@MainActor
final class AuthViewModel: ObservableObject {
    
    let engine: AuthenticationEngine
    
    init(engine: AuthenticationEngine) { self.engine = engine }
    
    // MARK: - Sign Up
    
    func signUp(email: String, password: String) async throws -> Result<AuthDataResultModel, AuthError> {
        let fieldErrors = validateAll(email, password)
        guard fieldErrors.isEmpty else { return .failure(.invalidForm) }
        
        do {
            let result = try await engine.createUser(email: email, password: password)
            return .success(result)
        } catch {
            let ns = error as NSError
            if ns.code == 1701118880 { return .failure(.emailInUse) }
            return .failure(.other)
        }
    }
    
    func validateAll(_ email: String, _ password: String) -> [FieldError] {
        var errors: [FieldError] = []
        if !AuthValidator.isValidEmail(email) { errors.append(.email) }
        if !AuthValidator.isValidPassword(password) { errors.append(.password) }
        return errors
    }
}
