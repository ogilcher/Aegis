//
//  Supabase.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import Foundation
import Supabase

@MainActor
final class Supabase {
    let supabase = SupabaseClient(
        supabaseURL: URL(string: Bundle.main.infoDictionary?["SUPABASE_URL"] as? String ?? "")!,
        supabaseKey: Bundle.main.infoDictionary?["SUPABASE_KEY"] as? String ?? ""
    )

}
