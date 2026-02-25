//
//  EncryptedRecord.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Encrypted Record

public struct EncryptedRecord: Codable, Equatable, Sendable {
    
    // MARK: - Properties
    
    public let userId: String
    public let recordType: String
    public let recordId: String
    
    public let updatedAt: Int64        // unix ms (portable)
    public let deleted: Bool
    
    public let envelope: EncryptedEnvelope
    
    public init(
        userId: String,
        recordType: String,
        recordId: String,
        updatedAt: Int64,
        deleted: Bool,
        envelope: EncryptedEnvelope
    ) {
        self.userId = userId
        self.recordType = recordType
        self.recordId = recordId
        self.updatedAt = updatedAt
        self.deleted = deleted
        self.envelope = envelope
    }
}

// MARK: - Encrypted Record Factory

public enum EncryptedRecordFactory {
    public static func nowUnixMillis() -> Int64 {
        Int64(Date().timeIntervalSince1970 * 1000.0)
    }
    
    public static func makeRecord(
        userId: String,
        domain: CryptoDomain,
        recordId: String,
        deleted: Bool,
        envelope: EncryptedEnvelope,
        updatedAt: Int64 = nowUnixMillis()
    ) -> EncryptedRecord {
        EncryptedRecord(
            userId: userId,
            recordType: domain.rawValue,
            recordId: recordId,
            updatedAt: updatedAt,
            deleted: deleted,
            envelope: envelope
        )
    }
}
