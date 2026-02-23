//
//  TamperTests.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import XCTest
import Aegis

final class TamperTests: XCTestCase {
    func testTamperCiphertextFails() throws {
        let crypto = EncryptionService()
        
        let plaintext = Data("hello world".utf8)
        print("Original plaintext:", String(decoding: plaintext, as: UTF8.self))
        
        let env = try crypto.encrypt(
            domain: .notes,
            recordId: "r1",
            plaintext: plaintext
        )
        
        print("\n--- ENCRYPTED ENVELOPE ---")
        print("Version:", env.v)
        print("Algorithm:", env.alg)
        print("Key ID:", env.kid)
        print("Ciphertext (base64url):", env.ct)
        print("----------------------------\n")
        
        // Tamper
        guard var ct = Data(base64URLString: env.ct) else {
            XCTFail("Failed to decode ciphertext")
            return
        }
        
        print("tampering first byte...")
        ct[0] ^= 0x01
        
        let tampered = EncryptedEnvelope(
            v: env.v,
            alg: env.alg,
            kid: env.kid,
            nonce: env.nonce,
            ct: ct.base64EncodedString(),
            aad: env.aad
        )
        
        do {
            let _ = try crypto.decrypt(
                domain: .notes,
                recordId: "r1",
                envelope: tampered
            )
            
            XCTFail("Decryption unexpectedly succeeded after tampering!")
        } catch {
            print("Decryption failed as expected.")
            print("Error thrown:", error)
        }
    }
}

