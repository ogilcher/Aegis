//
//  KeyringKeychainStore.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Keyring Keychain Store

public final class KeyringKeychainStore: KeyringStoring {
    
    // MARK: - Properties
    
    private let keychain: KeychainStore
    private let account: String
    private let service: String
    
    public init(
        keychian: KeychainStore = KeychainStore(),
        account: String = "aegis.keyring",
        service: String = "com.aegis.security"
    ) {
        self.keychain = keychian
        self.account = account
        self.service = service
    }
    
    // MARK: - Load
    
    public func load() throws -> Keyring? {
        guard let data = try keychain.readData(account: account, service: service) else { return nil }
        do { return try JSONDecoder().decode(Keyring.self, from: data) }
        catch { throw CryptoError.keyCorrupted }
    }
    
    // MARK: - Save
    
    public func save(_ keyring: Keyring) throws {
        let data: Data
        do { data = try JSONEncoder().encode(keyring) }
        catch { throw CryptoError.keyCorrupted }
        try keychain.upsertData(data, account: account, service: service)
    }
    
    // MARK: - Wipe
    
    public func wipe() throws {
        try keychain.delete(account: account, service: service)
    }
}
