//
//  CryptoContext.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/24/26.
//

import Foundation

// MARK: - Crypto Context

public final class CryptoContext {
    
    // MARK: - Properties
    
    public let userId: String
    public let crypto: EncryptionService
    
    public init(
        userId: String,
        crypto: EncryptionService = EncryptionService()
    ) {
        self.userId = userId
        self.crypto = crypto
    }
    
    // MARK: - Encrypt
    
    public func encrypt(
        domain: CryptoDomain,
        recordId: String,
        plaintext: Data
    ) throws -> EncryptedEnvelope {
        try crypto.encrypt(userId: userId, domain: domain, recordId: recordId, plaintext: plaintext)
    }
    
    // MARK: - Decrypt
    
    public func decrypt(
        domain: CryptoDomain,
        recordId: String,
        envelope: EncryptedEnvelope
    ) throws -> Data {
        try crypto.decrypt(userId: userId, domain: domain, recordId: recordId, envelope: envelope)
    }
}
