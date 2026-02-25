//
//  SecurityBootstrap.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/24/26.
//
//  Used by AppCoordinator to bootstrap security for the user,
//  initializing Config, UserId, Keychain, and other Crypto Services.
//

import Foundation

// MARK: - Security Bootstrap

public enum SecurityBootstrap {
    
    // MARK: - Config
    
    public struct Config: Sendable {
        public let keyProtection: KeyProtection
        
        public init(keyProtection: KeyProtection) {
            self.keyProtection = keyProtection
        }
    }
    
    // MARK: - Build
    
    public static func build(config: Config) throws -> SecurityServices {
        // 1. Stable app-scoped user id (Keychain)
        let identity = UserIdentityService()
        let userId = try identity.getOrCreateUserId()
        
        // 2. Keyring store policy (Keychain protected)
        let keyringStore = KeyringKeychainStore(protection: config.keyProtection)
        
        // 3. Key management + crypto services
        let keyManagement = KeyManagementService(store: keyringStore)
        let encryption = EncryptionService(KeyManagement: keyManagement)
        let cryptoContext = CryptoContext(userId: userId, crypto: encryption)
        
        return SecurityServices(userId: userId, crypto: cryptoContext)
    }
}
