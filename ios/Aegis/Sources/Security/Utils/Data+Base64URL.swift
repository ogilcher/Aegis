//
//  Data+Base64URL.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

// MARK: - Data Ext

public extension Data {
    func base64URLEncodedString() -> String {
        let b64 = self.base64EncodedString()
        return b64
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
    
    init?(base64URLString: String) {
        var s = base64URLString
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // Pad to multiples of 4
        let mod = s.count % 4
        if mod != 0 {
            s += String(repeating: "=", count: 4 - mod)
        }
        
        guard let data = Data(base64Encoded: s) else { return nil }
        self = data
    }
}
