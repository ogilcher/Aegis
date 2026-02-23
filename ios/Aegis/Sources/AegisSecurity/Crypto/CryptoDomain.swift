//
//  CryptoDomain.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Crypto Domain

public struct CryptoDomain: Hashable, Sendable {
    public let rawValue: String
    public init(_ rawValue: String) { self.rawValue = rawValue }
}

public extension CryptoDomain {
    static let notes = CryptoDomain("notes")
    static let health = CryptoDomain("health")
    
    // TODO: Add more domains as needed
}
