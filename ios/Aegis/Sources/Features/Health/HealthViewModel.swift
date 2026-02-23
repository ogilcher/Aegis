//
//  HealthViewModel.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import Foundation
import Combine

// MARK: - Health ViewModel

@MainActor
final class HealthViewModel: ObservableObject {
    
    func updateUserHealthProfile(
        _ healthProfile: UserHealthProfile
    ) async throws -> UserHealthProfile {
        #warning("Implement this, this currently does nothing")
        return healthProfile
    }
}
