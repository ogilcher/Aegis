//
//  ContentView.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/18/26.
//

import SwiftUI

// MARK: - Content View

struct ContentView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            AppRoot()
                .navigationDestination(for: AppScreen.self) { screen in
                    // Screen Registry
                }
        }
        .task {
            await coordinator.bootstrapSession()
        }
        .theme(.default)
    }
}

#Preview {
    ContentView()
}
