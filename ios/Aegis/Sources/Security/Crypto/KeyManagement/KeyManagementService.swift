//
//  KeyManagementService.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation
import CryptoKit

// MARK: - Key Management Service

public final class KeyManagementService {
    private let store: KeyringStoring
    
    public init(store: KeyringStoring = KeyringKeychainStore()) {
        self.store = store
    }
    
    // MARK: - Active Master Key
    
    public func activeMasterKey() throws -> (kid: UUID, key: SymmetricKey) {
        let keyring = try getOrCreateKeyring()
        let kid = keyring.activeKid
        guard let keyData = keyring.keysByKid[kid], keyData.count == 32 else {
            throw CryptoError.keyCorrupted
        }
        return (kid, SymmetricKey(data: keyData))
    }
    
    // MARK: - Master Key
    
    public func masterKey(for kid: UUID) throws -> SymmetricKey {
        let keyring = try getOrCreateKeyring()
        guard let keyData = keyring.keysByKid[kid], keyData.count == 32 else {
            throw CryptoError.keyNotFound
        }
        return SymmetricKey(data: keyData)
    }
    
    // MARK: - Rotate Master Key
    
    public func rotateMasterKey() throws -> UUID {
        var keyring = try getOrCreateKeyring()
        
        let newKid = UUID()
        let newKeyData = try generateRandom32()
        
        keyring.keysByKid[newKid] = newKeyData
        keyring.activeKid = newKid
        
        try store.save(keyring)
        return newKid
    }
    
    // MARK: - GetOrCreate Keyring
    
    private func getOrCreateKeyring() throws -> Keyring {
        if let existing = try store.load() {
            return existing
        }
        
        let kid = UUID()
        let keyData = try generateRandom32()
        let keyring = Keyring(activeKid: kid, keysByKid: [kid: keyData])
        
        try store.save(keyring)
        return keyring
        
    }
    
    // MARK: - Generate Random32
    
    private func generateRandom32() throws -> Data {
        var bytes = Data(count: 32)
        let status = bytes.withUnsafeMutableBytes { buffer in
            SecRandomCopyBytes(kSecRandomDefault, 32, buffer.baseAddress!)
        }
        guard status == errSecSuccess else { throw CryptoError.keyCorrupted }
        return bytes
    }
    
    // MARK: - Wipe
    
    public func wipeAllKeys() throws {
        try store.wipe()
    }
}
