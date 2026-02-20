//
//  ThemeEnvironment.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/18/26.
//
//  Environment plumbing for injecting Theme into SwiftUI views.
//

import SwiftUI

// MARK: - Theme Environment Key

private struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: Theme = .default
}

// MARK: - EnvironmentValues

public extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Convenience

public extension View {
    
    /// Inject a Theme into the view hierarchy.
    func theme(_ theme: Theme) -> some View {
        environment(\.theme, theme)
    }
}
