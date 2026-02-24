//
//  CryptoError.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Crypto Error

public enum CryptoError: Error, Equatable {
    case keyNotFound
    case keyCorrupted
    case encryptionFailed
    case decryptionFailed
    case unspportedVersion(Int)
    case invalidEnvelope
}
