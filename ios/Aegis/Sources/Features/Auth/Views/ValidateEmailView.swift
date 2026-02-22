//
//  ValidateEmailView.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/22/26.
//

import SwiftUI

struct ValidateEmailView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack (spacing: 20) {
            Text("We sent a link to your email")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Image(systemName: "envelope")
                .font(.largeTitle.bold())
        }
    }
}

#Preview {
    ValidateEmailView()
}
