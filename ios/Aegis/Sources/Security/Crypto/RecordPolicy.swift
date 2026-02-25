//
//  RecordPolicy.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//
//  Prevents accidental metadata leakage later when
//  building models.
//

import Foundation

// MARK: - Record Policy

public struct RecordPolicy: Sendable {
    public let domain: CryptoDomain
    
    // Declare what's safe to remain plaintext for server indexing
    public let allowedPlaintextFields: Set<String>
    
    public init(domain: CryptoDomain, allowedPlaintextFields: Set<String>) {
        self.domain = domain
        self.allowedPlaintextFields = allowedPlaintextFields
    }
}

// MARK: - Record Policy Registry

public enum RecordPolicyRegistry {
    public static let kDefaultPlaintext: Set<String> = [
        "user_id", "record_type", "record_id", "updated_at", "deleted"
    ]
    
    public static func policy(for domain: CryptoDomain) -> RecordPolicy {
        RecordPolicy(domain: domain, allowedPlaintextFields: kDefaultPlaintext)
    }
}
