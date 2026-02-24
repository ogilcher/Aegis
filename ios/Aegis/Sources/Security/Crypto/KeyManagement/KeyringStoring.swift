//
//  KeyringStoring.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Keyring Storing

public protocol KeyringStoring {
    func load() throws -> Keyring?
    func save(_ keyring: Keyring) throws
    func wipe() throws
}
