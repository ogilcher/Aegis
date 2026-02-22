//
//  SignUpViewModel.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/20/26.
//

import Foundation
import Combine

// MARK: - SignUp ViewModel

@MainActor
final class SignUpViewModel: ObservableObject {
    enum FieldError: Hashable { case email, password }
    enum AuthError: Error, Equatable { case invalidForm, emailInUse, other }
    
    let engine: AuthenticationEngine
    
    init(engine: AuthenticationEngine) { self.engine = engine }
    
    // MARK: - Sign Up
    
    func signUp(email: String, password: String) async throws -> Result<AuthDataResultModel, AuthError> {
        let fieldErrors = validateAll(email, password)
        guard fieldErrors.isEmpty else { return .failure(.invalidForm)}
        
        do {
            guard let result = try? await engine.createUser(email: email, password: password) else { throw AuthError.other }
            return .success(result)
        } catch {
            let ns = error as NSError
            if ns.code == 1701178237 { return .failure(.emailInUse) }
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
