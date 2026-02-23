//
//  UserHealthProfile.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation

struct UserHealthProfile: Codable, Identifiable, Sendable {
    
    // MARK: - Properties
    
    let id: UUID
    
    let weightLbs: Double
    let heightInches: Double
    
    let createdAt: Date
    let updatedAt: Date
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id
        case weightLbs = "weight_lbs"
        case heightInches = "height_inches"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
