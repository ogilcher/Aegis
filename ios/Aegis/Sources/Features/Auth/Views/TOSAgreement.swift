//
//  TOSAgreement.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/20/26.
//

import SwiftUI

// MARK: - TOS Agreement

struct TOSAgreement: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack (spacing: 20) {
            
            Text("TOS Agreement")
                .font(.largeTitle.bold())
            
            Divider()
            
            PrimaryButton("Sign Up") {
                coordinator.push(.auth(.signUp))
            }
            
            PrimaryButton("Sign In") {
                coordinator.push(.auth(.signIn))
            }
            
            // Traditionally you would have the user validate some TOS agreement here before continuing, but for this purpose we will allow them to just pass through
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = AppCoordinator()
    
    TOSAgreement()
        .environmentObject(coordinator)
        
}
