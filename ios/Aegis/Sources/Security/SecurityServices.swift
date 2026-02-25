//
//  SecurityServices.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/24/26.
//
//  Container for quick-access crypto contexts
//

import Foundation

// MARK: - Security Services

public struct SecurityServices: Sendable {
    public let userId: String
    public let crypto: CryptoContext
}
