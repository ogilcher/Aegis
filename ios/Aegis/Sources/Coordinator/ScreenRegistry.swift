//
//  ScreenRegistry.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/20/26.
//

import SwiftUI

// MARK: - Screen Registry

struct ScreenRegistry {
    @MainActor
    static func build(for screen: AppScreen, coordinator: AppCoordinator) -> some View {
        switch screen {
            
        // MARK: - Auth
            
        case .auth(let path):
            guard let vm = coordinator.authViewModel else {
                return AnyView(AppRoot())
            }
            
            switch path {
            case .tosAgreement:     return AnyView(TOSAgreement())
            case .signIn:           return AnyView(SignInView().navigationBarBackButtonHidden())
            case .signUp:           return AnyView(SignUpView(viewModel: vm).navigationBarBackButtonHidden())
            case .validateEmail:    return AnyView(ValidateEmailView().navigationBarBackButtonHidden())
            }

        case .root:                 return AnyView(AppRoot().navigationBarBackButtonHidden())
        case .home:                 return AnyView(HomeScreen().navigationBarBackButtonHidden())
        }
    }
}
