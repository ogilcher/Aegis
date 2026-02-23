//
//  EncryptedEnvelope.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Encrypted Envelope

public struct EncryptedEnvelope: Codable, Equatable, Sendable {
    public let v: Int
    public let alg: String
    public let kid: String
    public let nonce: String    // base64url
    public let ct: String       // base64url (ciphertext+tag for CryptoKit sealed box combined)
    public let aad: String      // base64url (useful for debugging/verification)
    
    public init(
        v: Int,
        alg: String,
        kid: String,
        nonce: String,
        ct: String,
        aad: String
    ) {
        self.v = v
        self.alg = alg
        self.kid = kid
        self.nonce = nonce
        self.ct = ct
        self.aad = aad
    }
}
