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
            ScreenRegistry.build(for: coordinator.root, coordinator: coordinator)
                .navigationDestination(for: AppScreen.self) { screen in
                    ScreenRegistry.build(for: screen, coordinator: coordinator)
                }
        }
        .task {
            await coordinator.bootstrapSession()
        }
        .onOpenURL { url in
            coordinator.handleAuthCallback(url)
        }
        .environmentObject(coordinator)
        .theme(.default)
    }
}

#Preview {
    ContentView()
}
