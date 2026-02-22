//
//  DBUserRepository.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/22/26.
//

import Foundation
import Supabase

// MARK: - DBUser Repo

final class DBUserRepository {
    
    private let db: SupabaseClient
    
    init (db: SupabaseClient = Supabase.client) {
        self.db = db
    }
    
    // TODO: Make this hook into FastAPI
}
