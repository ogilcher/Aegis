//
//  AppRoot.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import SwiftUI

// MARK: - App Root

struct AppRoot: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack (spacing: 40) {
            Text("Project Aegis")
                .font(.largeTitle.bold())
            
            Spacer()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
            
            Text("Loading app...")
                .font(.title3)
        }
        .frame(height: 300)
    }
}

#Preview {
    AppRoot()
}
