//
//  Validators.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import Foundation

enum AuthValidator {
    static func isValidEmail(_ text: String) -> Bool {
        let regex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    static func isValidPassword(_ text: String) -> Bool {
        // 8+, 1 lower, 1 upper, 1 digit, 1 special
        let regex = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
}
