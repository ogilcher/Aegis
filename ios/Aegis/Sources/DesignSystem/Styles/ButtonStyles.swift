//
//  ButtonStyles.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/18/26.
//

import SwiftUI

// MARK: - PrimaryButtonStyle

struct PrimaryButtonStyle: ButtonStyle {
    
    let theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(theme.typography.button)
            .foregroundStyle(theme.colors.onPrimary)
            .padding(.vertical, theme.spacing.m)
            .padding(.horizontal, theme.spacing.l)
            .background(background(configuration))
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.m))
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
    
    private func background(_ configuration: Configuration) -> some ShapeStyle {
        theme.colors.primary
    }
}

// MARK: - SecondaryButtonStyle

struct SecondaryButtonStyle: ButtonStyle {
    
    let theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(theme.typography.button)
            .foregroundStyle(theme.colors.primary)
            .padding(.vertical, theme.spacing.m)
            .padding(.horizontal, theme.spacing.l)
            .background(background(configuration))
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.m))
            .overlay(RoundedRectangle(cornerRadius: theme.radius.m).stroke(theme.colors.primary, lineWidth: 2))
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
    
    private func background(_ configuration: Configuration) -> some ShapeStyle {
        theme.colors.onSecondary
    }
}

// MARK: - DestructiveButtonStyle

struct DestructiveButtonStyle: ButtonStyle {
    
    let theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(theme.typography.button)
            .foregroundStyle(theme.colors.onPrimary)
            .padding(.vertical, theme.spacing.m)
            .padding(.horizontal, theme.spacing.l)
            .background(background(configuration))
            .clipShape(RoundedRectangle(cornerRadius: theme.radius.m))
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
    
    private func background(_ configuration: Configuration) -> some ShapeStyle {
        theme.colors.danger
    }
}
