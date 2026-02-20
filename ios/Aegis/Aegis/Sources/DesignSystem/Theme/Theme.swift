//
//  Theme.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/18/26.
//
//  Central theme object consumed by DesignSystem components.
//  Theme is a composition of color + typography + spacing + radii tokens.
//

import SwiftUI

// MARK: - Theme

public struct Theme: Sendable {
    
    // MARK: - Nested Types
    
    public struct Colors: Sendable {
        public let primary: AnyShapeStyle
        public let onPrimary: AnyShapeStyle
        public let onSecondary: AnyShapeStyle
        
        public let background: AnyShapeStyle
        public let surface: AnyShapeStyle
        
        public let textPrimary: AnyShapeStyle
        public let textSecondary: AnyShapeStyle
        
        public let border: AnyShapeStyle
        public let danger: AnyShapeStyle
        public let onDanger: AnyShapeStyle
        
        public init(
            primary: AnyShapeStyle,
            onPrimary: AnyShapeStyle,
            onSecondary: AnyShapeStyle,
            background: AnyShapeStyle,
            surface: AnyShapeStyle,
            textPrimary: AnyShapeStyle,
            textSecondary: AnyShapeStyle,
            border: AnyShapeStyle,
            danger: AnyShapeStyle,
            onDanger: AnyShapeStyle
        ) {
            self.primary = primary
            self.onPrimary = onPrimary
            self.onSecondary = onSecondary
            self.background = background
            self.surface = surface
            self.textPrimary = textPrimary
            self.textSecondary = textSecondary
            self.border = border
            self.danger = danger
            self.onDanger = onDanger
        }
    }
    
    public struct Typography: Sendable {
        public let title: Font
        public let body: Font
        public let caption: Font
        public let button: Font
        
        public init(
            title: Font,
            body: Font,
            caption: Font,
            button: Font
        ) {
            self.title = title
            self.body = body
            self.caption = caption
            self.button = button
        }
    }
    
    public struct Spacing: Sendable {
        public let xs: CGFloat
        public let s: CGFloat
        public let m: CGFloat
        public let l: CGFloat
        public let xl: CGFloat
        
        public init(xs: CGFloat, s: CGFloat, m: CGFloat, l: CGFloat, xl: CGFloat) {
            self.xs = xs
            self.s = s
            self.m = m
            self.l = l
            self.xl = xl
        }
    }
    
    public struct Radius: Sendable {
        public let s: CGFloat
        public let m: CGFloat
        public let l: CGFloat
        
        public init(s: CGFloat, m: CGFloat, l: CGFloat) {
            self.s = s
            self.m = m
            self.l = l
        }
    }
    
    // MARK: - Stored Properties
    
    public let colors: Colors
    public let typography: Typography
    public let spacing: Spacing
    public let radius: Radius
    
    // MARK: - Init
    
    public init(
        colors: Colors,
        typography: Typography,
        spacing: Spacing,
        radius: Radius
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.radius = radius
    }
}

// MARK: - Defaults

public extension Theme {
    
    /// Default theme used if the app dosen't inject one.
    static let `default` = Theme(
        colors: Colors(
            primary: AnyShapeStyle(Color.accentColor),
            onPrimary: AnyShapeStyle(Color.white),
            onSecondary: AnyShapeStyle(Color.clear),
            background: AnyShapeStyle(Color(.systemBackground)),
            surface: AnyShapeStyle(Color(.secondarySystemBackground)),
            textPrimary: AnyShapeStyle(Color.primary),
            textSecondary: AnyShapeStyle(Color.secondary),
            border: AnyShapeStyle(Color(.separator)),
            danger: AnyShapeStyle(Color.red),
            onDanger: AnyShapeStyle(Color.white)
        ),
        typography: Typography(
            title: .system(.title2, design: .rounded).weight(.semibold),
            body: .system(.body, design: .rounded),
            caption: .system(.caption, design: .rounded),
            button: .system(.headline, design: .rounded).weight(.semibold)
        ),
        spacing: Spacing(xs: 4, s: 8, m: 12, l: 16, xl: 24),
        radius: Radius(s: 10, m: 14, l: 18)
    )
}

