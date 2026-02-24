//
//  RotationTests.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import XCTest
@testable import Aegis

final class RotationTests: XCTestCase {
    func testDecryptWithHoldKidAfterRotation() throws {
        let store = KeyringKeychainStore()
        let kms = KeyManagementService(store: store)
        let crypto = EncryptionService(KeyManagement: kms)
        
        let userId = "user-123"
        let domain: CryptoDomain = .notes
        let recordId = "r1"
        let plaintext1 = Data("first".utf8)
        
        let env1 = try crypto.encrypt(
            userId: userId,
            domain: domain,
            recordId: recordId,
            plaintext: plaintext1
        )
        
        let newKid = try kms.rotateMasterKey()
        XCTAssertNotEqual(env1.kid, newKid.uuidString)
        
        let plaintext2 = Data("second".utf8)
        let env2 = try crypto.encrypt(
            userId: userId,
            domain: domain,
            recordId: recordId,
            plaintext: plaintext2
        )
        XCTAssertEqual(env2.kid, newKid.uuidString)
        
        let decrypted1 = try crypto.decrypt(
            userId: userId,
            domain: domain,
            recordId: recordId,
            envelope: env1
        )
        XCTAssertEqual(decrypted1, plaintext1)
        
        let decrypted2 = try crypto.decrypt(
            userId: userId,
            domain: domain,
            recordId: recordId,
            envelope: env2
        )
        XCTAssertEqual(decrypted2, plaintext2)
    }
}
