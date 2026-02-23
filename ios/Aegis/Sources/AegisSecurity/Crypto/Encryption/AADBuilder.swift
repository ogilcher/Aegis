//
//  AADBuilder.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//
//  AAD binds encryption to metadata (prevents swapping ciphertext between records/types)
//

import Foundation

// MARK: - AADBuilder

public enum AADBuilder {
    public static func build(
        version: Int,
        domain: CryptoDomain,
        recordId: String
    ) -> Data {
        let s = "v=\(version)|domain=\(domain.rawValue)|rid=\(recordId)"
        return Data(s.utf8)
    }
}

