//
//  EnvelopeCodec.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Envelope Codec

public enum EnvelopeCodec {
    private static let kDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private static let kEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = []
        return encoder
    }()
    
    public static func encode(_ envelope: EncryptedEnvelope) throws -> Data {
        do { return try kEncoder.encode(envelope) }
        catch { throw CryptoError.invalidEnvelope }
    }
    
    public static func decode(_ data: Data) throws -> EncryptedEnvelope {
        do { return try kDecoder.decode(EncryptedEnvelope.self, from: data) }
        catch { throw CryptoError.invalidEnvelope }
    }
}
