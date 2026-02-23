//
//  Session.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/22/26.
//

import Foundation

// MARK: - SessionState

public enum SessionState: Equatable, Sendable {
    case signOut
    case awaitEmailVerification(AwaitingEmailVerification)
    case signedIn(Session)
}

// MARK: - AwaitingEmailVerification

public struct AwaitingEmailVerfication: Equatable, Sendable {
    public let email: String
    public let startedAt: Date
    
    public init(email: String, startedAt: Date = Date()) {
        self.email = email
        self.startedAt = startedAt
    }
}

// MARK: - Session

public struct Session: Equatable, Sendable {
    
    // MARK: - Properties
    
    public let userId: UUID
    public let email: String?
    public let createdAt: Date?
    public let lastSignInAt: Date?
    public let isEmailVerified: Bool
    
    // MARK: - Init
    
    public init(
        userId: UUID,
        email: String?,
        createdAt: Date?,
        lastSignInAt: Date?,
        isEmailVerified: Bool
    ) {
        self.userId = userId
        self.email = email
        self.createdAt = createdAt
        self.lastSignInAt = lastSignInAt
        self.isEmailVerified = isEmailVerified
    }
}
