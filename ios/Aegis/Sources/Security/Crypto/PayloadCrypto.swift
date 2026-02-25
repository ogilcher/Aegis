//
//  PayloadCrypto.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//
//  Becomes the single "encode/decode payload" gateway
//

import Foundation

// MARK: - Payload Crypto

public final class PayloadCrypto {
    private let crypto: EncryptionService
    
    public init(crypto: EncryptionService = EncryptionService()) {
        self.crypto = crypto
    }
    
    // MARK: - Encrypt Codable
    
    public func encryptCodable<T: Codable>(
        userId: String,
        domain: CryptoDomain,
        recordId: String,
        value: T
    ) throws -> EncryptedEnvelope {
        let data = try JSONEncoder().encode(value)
        return try crypto.encrypt(
            userId: userId,
            domain: domain,
            recordId: recordId,
            plaintext: data
        )
    }

    // MARK: - Decrypt Codable
    
    public func decryptCodable<T: Codable>(
        userId: String,
        domain: CryptoDomain,
        recordId: String,
        envelope: EncryptedEnvelope,
        as type: T.Type
    ) throws -> T {
        let data = try crypto.decrypt(
            userId: userId,
            domain: domain,
            recordId: recordId,
            envelope: envelope
        )
        return try JSONDecoder().decode(T.self, from: data)
    }
}
