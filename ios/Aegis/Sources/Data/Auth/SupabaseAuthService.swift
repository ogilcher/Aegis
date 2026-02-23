//
//  SupabaseAuthService.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/22/26.
//

import Foundation

extension Session {
    static func fromSupabaseUser(
        userId: UUID,
        email: String?,
        createdAt: Date?,
        lastSignInAt: Date?,
        emailConfirmedAt: Date?
    ) -> Session {
        Session(
            userId: userId,
            email: email,
            createdAt: createdAt,
            lastSignInAt: lastSignInAt,
            isEmailVerified: emailConfirmedAt != nil)
    }
}
