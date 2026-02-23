//
//  KeychainStore.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation
import Security

// MARK: - KeychainStore

public final class KeychainStore {
    public init() {}
    
    // MARK: - Read Data
    
    public func readData(account: String, service: String) throws -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecItemNotFound { return nil }
        guard status == errSecSuccess else { throw CryptoError.keyCorrupted }
        
        guard let data = item as? Data else { throw CryptoError.keyCorrupted }
        return data
    }
    
    // MARK: - Upsert Data
    
    public func upsertData(_ data: Data, account: String, service: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        let attrs: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attrs as CFDictionary)
        if status == errSecItemNotFound {
            var addQuery = query
            addQuery.merge(attrs) { _, new in new }
            let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
            guard addStatus == errSecSuccess else { throw CryptoError.keyCorrupted }
            return
        }
        
        guard status == errSecSuccess else { throw CryptoError.keyCorrupted }
    }
    
    // MARK: - Delete
    
    public func delete(account: String, service: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw CryptoError.keyCorrupted
        }
    }
}
