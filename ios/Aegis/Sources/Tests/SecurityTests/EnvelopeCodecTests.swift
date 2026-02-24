//
//  EnvelopeCodecTests.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import XCTest
@testable import Aegis

final class EnvelopeCodecTests: XCTestCase {
    func testCodecRoundTrip() throws {
        let store = KeyringKeychainStore()
        let crypto = EncryptionService(KeyManagement: KeyManagementService(store: store))
        
        let env = try crypto.encrypt(
            userId: "user-123",
            domain: .notes,
            recordId: "r1",
            plaintext: Data("hello".utf8)
        )
        
        let data = try EnvelopeCodec.encode(env)
        let decoded = try EnvelopeCodec.decode(data)
        XCTAssertEqual(decoded, env)
    }
}
