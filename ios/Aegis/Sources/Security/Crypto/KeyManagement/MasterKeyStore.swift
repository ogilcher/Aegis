//
//  MasterKeyStore.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation
import CryptoKit

// MARK: - Master Key Record

public struct MasterKeyRecord: Codable, Equatable, Sendable {
    public let kid: UUID
    public let key: Data // 32 bytes
}

// MARK: - Master Key Store

public final class MasterKeyStore {
    
    // MARK: - Properties
    
    private let keychain: KeychainStore
    private let account: String
    private let service: String
    
    // MARK: - Init
    
    public init(
        keychain: KeychainStore = KeychainStore(),
        account: String = "aegis.masterkey",
        service: String = "com.aegis.security"
    ) {
        self.keychain = keychain
        self.account = account
        self.service = service
    }
    
    // MARK: - Load Func
    
    public func load() throws -> MasterKeyRecord? {
        guard let data = try keychain.readData(account: account, service: service) else { return nil }
        return try JSONDecoder().decode(MasterKeyRecord.self, from: data)
    }
    
    // MARK: - Save
    
    public func save(_ record: MasterKeyRecord) throws {
        let data = try JSONEncoder().encode(record)
        try keychain.upsertData(data, account: account, service: service)
    }
    
    // MARK: - Wipe
    
    public func wipe() throws {
        try keychain.delete(account: account, service: service)
    }
}
