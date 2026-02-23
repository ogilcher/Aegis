//
//  KeyDerivation.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation
import CryptoKit

// MARK: - Key Derivation

public enum KeyDerivation {
    
    // MARK: - Derive Domain Key
    
    public static func deriveDomainKey(masterKey: SymmetricKey, domain: CryptoDomain) -> SymmetricKey {
        let info = Data(("aegis.domain." + domain.rawValue).utf8)
        return HKDF<SHA256>.deriveKey(
            inputKeyMaterial: masterKey,
            salt: Data(),
            info: info,
            outputByteCount: 32
        )
    }
    
    // MARK: - Derive Record Key
    
    public static func deriveRecordKey(domainKey: SymmetricKey, recordId: String) -> SymmetricKey {
        let info = Data(("aegis.record." + recordId).utf8)
        return HKDF<SHA256>.deriveKey(
            inputKeyMaterial: domainKey,
            salt: Data(),
            info: info,
            outputByteCount: 32
        )
    }
}
