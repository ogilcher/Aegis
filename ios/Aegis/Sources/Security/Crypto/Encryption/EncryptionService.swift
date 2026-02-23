//
//  EncryptionService.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//
//  Store combined representation of CryptoKit's AES.GCM.seal's SealedBox
//

import Foundation
import CryptoKit

// MARK: - Encryption Service

public final class EncryptionService {
    private let keyManagement: KeyManagementService
    
    public init(KeyManagement: KeyManagementService = KeyManagementService()) {
        self.keyManagement = KeyManagement
    }
    
    // MARK: - Encrypt
    
    public func encrypt(
        domain: CryptoDomain,
        recordId: String,
        plaintext: Data
    ) throws -> EncryptedEnvelope {
        let (kid, masterKey) = try keyManagement.getOrCreateMasterKey()
        let domainKey = KeyDerivation.deriveDomainKey(masterKey: masterKey, domain: domain)
        let recordKey = KeyDerivation.deriveRecordKey(domainKey: domainKey, recordId: recordId)
        
        let version = 1
        let aad = AADBuilder.build(version: version, domain: domain, recordId: recordId)
        
        do {
            let sealed = try AES.GCM.seal(plaintext, using: recordKey, authenticating: aad)
            guard let combined = sealed.combined else { throw CryptoError.encryptionFailed }
            
            return EncryptedEnvelope(
                v: version,
                alg: "A256GCM",
                kid: kid.uuidString,
                nonce: Data(sealed.nonce).base64EncodedString(),
                ct: combined.base64URLEncodedString(),
                aad: aad.base64URLEncodedString()
            )
        } catch {
            throw CryptoError.encryptionFailed
        }
    }
    
    // MARK: - Decrypt
    
    public func decrypt(
        domain: CryptoDomain,
        recordId: String,
        envelope: EncryptedEnvelope
    ) throws -> Data {
        guard envelope.v == 1 else { throw CryptoError.unspportedVersion(envelope.v) }
        guard envelope.alg == "A256GCM" else { throw CryptoError.invalidEnvelope }
        
        let (_, masterKey) = try keyManagement.getOrCreateMasterKey()
        let domainKey = KeyDerivation.deriveDomainKey(masterKey: masterKey, domain: domain)
        let recordKey = KeyDerivation.deriveRecordKey(domainKey: domainKey, recordId: recordId)
        
        let expectedAAD = AADBuilder.build(version: envelope.v, domain: domain, recordId: recordId)
        
        guard let combined = Data(base64URLString: envelope.ct) else { throw CryptoError.invalidEnvelope }
        
        do {
            let sealed = try AES.GCM.SealedBox(combined: combined)
            return try AES.GCM.open(sealed, using: recordKey, authenticating: expectedAAD)
        } catch {
            throw CryptoError.decryptionFailed
        }
    }
}
