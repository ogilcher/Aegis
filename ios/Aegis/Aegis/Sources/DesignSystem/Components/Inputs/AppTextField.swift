//
//  AppTextField.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/18/26.
//

import SwiftUI

// MARK: - Helper Enums

public enum FieldState {
    case normal
    case focused
    case error
    case disabled
}

public enum FieldType {
    case text
    case email
    case password
    case number
    case decimal
    case search
}

// MARK: - AppTextField

public struct AppTextField: View {
    
    // MARK: - Properties
    
    private let title: String
    @Binding private var text: String
    
    private let fieldType: FieldType
    private let state: FieldState
    
    @FocusState private var isFocused: Bool
    @Environment(\.theme) private var theme
    
    // MARK: - Init
    
    public init(
        _ title: String,
        text: Binding<String>,
        type: FieldType = .text,
        state: FieldState = .normal,
    ) {
        self.title = title
        self._text = text
        self.fieldType = type
        self.state = state
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            inputField
                .textFieldStyle(
                    AppTextFieldStyle(
                        theme: theme,
                        isFocused: isFocused,
                        isError: (state == .error),
                    )
                )
                .focused($isFocused)
                .keyboardType(keyboard)
        
        }
    }
    
    @ViewBuilder
    private var inputField: some View {
        if fieldType == .password {
            SecureField(title, text: $text)
        } else {
            TextField(title, text: $text)
        }
    }
    
    private var keyboard: UIKeyboardType {
        switch fieldType {
        case .text:     return UIKeyboardType.default
        case .email:    return UIKeyboardType.emailAddress
        case .password: return UIKeyboardType.asciiCapable
        case .number:   return UIKeyboardType.numberPad
        case .decimal:  return UIKeyboardType.decimalPad
        case .search:   return UIKeyboardType.asciiCapableNumberPad
        }
    }
}

#Preview {
    @Previewable @State var someText: String = ""
    
    VStack (spacing: 20) {
        AppTextField("Text", text: $someText)
        AppTextField("Email", text: $someText, type: .email)
        AppTextField("Password", text: $someText, type: .password)
        AppTextField("Number", text: $someText, type: .number)
        AppTextField("Decimal", text: $someText, type: .decimal)
        AppTextField("Search", text: $someText, type: .search)
    }
    .padding()
}
