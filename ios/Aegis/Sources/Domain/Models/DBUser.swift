//
//  DBUser.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/20/26.
//

import Foundation

struct DBUser: Codable, Identifiable, Sendable {
    
    // MARK: - Properties
    
    let id: UUID
    let email: String?
    
    let createdAt: Date
    let updatedAt: Date
    
    let lastLoginAt: Date?
    let isDeleted: Bool
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastLoginAt = "last_login_at"
        case isDeleted = "is_deleted"
    }
}
