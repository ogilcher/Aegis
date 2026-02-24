//
//  Keyring.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Keyring

public struct Keyring: Codable, Equatable, Sendable {
    public var activeKid: UUID
    public var keysByKid: [UUID: Data] // each Data is 32 bytes
    
    public init(activeKid: UUID, keysByKid: [UUID: Data]) {
        self.activeKid = activeKid
        self.keysByKid = keysByKid
    }
}
