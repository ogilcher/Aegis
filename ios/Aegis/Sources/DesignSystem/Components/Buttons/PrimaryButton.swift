//
//  PrimaryButton.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/18/26.
//
//  Primary action button used across the app.
//  Consumes design tokens and theme configuration
//  No feature-specific logic allowed.

import SwiftUI

// MARK: - PrimaryButton

public struct PrimaryButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let action: () -> Void
    
    private var isLoading: Bool
    private var isDisabled: Bool
    private var fullWidth: Bool
    
    @Environment(\.theme) private var theme
    
    // MARK: - Init
    
    public init(
        _ title: String,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        fullWidth: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.fullWidth = fullWidth
        self.action = action
    }
    
    // MARK: - Body
    
    public var body: some View {
        Button(
            action: handleTap,
            label: content
        )
        .buttonStyle(PrimaryButtonStyle(theme: theme))
        .disabled(isDisabled || isLoading)
        .frame(maxWidth: fullWidth ? .infinity : nil)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        
    }
    
    // MARK: - Content
    
    @ViewBuilder
    private func content() -> some View {
        if isLoading {
            ProgressView()
        } else {
            Text(title)
        }
    }
    
    // MARK: - Actions
    
    private func handleTap() {
        guard !isLoading && !isDisabled else { return }
        action()
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton("Continue") {}
        
        PrimaryButton("Loading", isLoading: true) {}
        
        PrimaryButton("Disabled", isDisabled: true) {}
    }
    .padding()
}
