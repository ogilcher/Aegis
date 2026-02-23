//
//  Supabase.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import Foundation
import Supabase

// MARK: - Supabase

final class Supabase {
    
    // MARK: - Client
    
    static var client: SupabaseClient {
        
        print("trying to use key: \(Bundle.main.infoDictionary?["SUPABASE_KEY"] ?? "nil")")
        print("trying to use url: \(Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL"), default: "")")
        
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String else { fatalError() }
        guard let key = Bundle.main.infoDictionary?["SUPABASE_KEY"] as? String else { fatalError() }
        
        let url = URL(string: "https://\(urlString)")!
        
        return SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
    
    // MARK: - Helpers
    
    func establishSession(_ url: URL) async throws {
        Supabase.client.auth.handle(url)
    }
}
