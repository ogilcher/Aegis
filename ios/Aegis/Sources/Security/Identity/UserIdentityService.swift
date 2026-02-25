//
//  UserIdentityService.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/24/26.
//

import Foundation

// MARK: - User Identity Service

public final class UserIdentityService {
    
    // MARK: - Properties
    
    private let keychain: KeychainStore
    private let account: String
    private let service: String
    
    public init(
        keychain: KeychainStore = KeychainStore(),
        account: String = "aegis.user_id",
        service: String = "com.aegis.security"
    ) {
        self.keychain = keychain
        self.account = account
        self.service = service
    }
    
    // MARK: - Get or Create UserId
    
    public func getOrCreateUserId() throws -> String {
        if let data = try keychain.readData(account: account, service: service),
           let s = String(data: data, encoding: .utf8),
           !s.isEmpty {
            return s
        }
        
        let newId = UUID().uuidString.lowercased()
        guard let data = newId.data(using: .utf8) else { throw CryptoError.keyCorrupted }
        try keychain.upsertData(data, account: account, service: service)
        return newId
    }
    
    // MARK: - Reset UserId
    
    public func resetUserId() throws {
        try keychain.delete(account: account, service: service)
    }
    
}
