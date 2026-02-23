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
    private let store: MasterKeyStore
    
    public init(store: MasterKeyStore = MasterKeyStore()) {
        self.store = store
    }
    
    // MARK: - GetOrCreate Master Key
    
    public func getOrCreateMasterKey() throws -> (kid: UUID, key: SymmetricKey) {
        if let existing = try store.load() {
            guard existing.key.count == 32 else { throw CryptoError.keyCorrupted }
            return (existing.kid, SymmetricKey(data: existing.key))
        }
        
        let kid = UUID()
        var bytes = Data(count: 32)
        let result = bytes.withUnsafeMutableBytes { buffer in
            SecRandomCopyBytes(kSecRandomDefault, 32, buffer.baseAddress!)
        }
        guard result == errSecSuccess else { throw CryptoError.keyCorrupted }
        
        let record = MasterKeyRecord(kid: kid, key: bytes)
        try store.save(record)
        return (kid, SymmetricKey(data: bytes))
    }
    
    // MARK: - Wipe
    
    public func wipeAllKeys() throws {
        try store.wipe()
    }
}
