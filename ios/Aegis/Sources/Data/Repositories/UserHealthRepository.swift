//
//  UserHealthRepository.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation
import Supabase

// MARK: - User Health Repo

final class UserHealthRepository {
    
    private let db: SupabaseClient
    
    init(db: SupabaseClient = Supabase.client) {
        self.db = db
    }
    
    
}
