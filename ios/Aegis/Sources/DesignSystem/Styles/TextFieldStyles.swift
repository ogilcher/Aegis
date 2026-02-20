//
//  TextFieldStyles.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/18/26.
//

import SwiftUI

// MARK: - AppTextFieldStyle

public struct AppTextFieldStyle: TextFieldStyle {
    
    let theme: Theme
    let isFocused: Bool
    let isError: Bool
    
    public init(theme: Theme, isFocused: Bool, isError: Bool) {
        self.theme = theme
        self.isFocused = isFocused
        self.isError = isError
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(theme.typography.body)
            .padding(theme.spacing.m)
            .background(theme.colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: theme.radius.m)
                    .stroke(borderColor, lineWidth: 2)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: theme.radius.m)
            )
    }
    
    private var borderColor: AnyShapeStyle {
        if isError {
            return theme.colors.danger
        } else if isFocused {
            return theme.colors.primary
        } else {
            return theme.colors.border
        }
    }
    
    
}
