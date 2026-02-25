//
//  KeyProtection.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/24/26.
//

import Foundation
import Security

// MARK: - Key Protection

public enum KeyProtection: Sendable {
    // Default: device unlocked, not migratable
    case whenUnlockedThisDeviceOnly
    
    // Stronger: requires (biometric/password) per access
    case userPresenceThisDeviceOnly
}
