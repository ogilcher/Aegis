//
//  AppScreens.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/24/26.
//

// MARK: - App Screen

enum AppScreen: Hashable {
    
    case auth(AuthPath)
    case health(HealthPath)
    
    // Main root
    case root
    case home
    
    // TODO: Category Routing
}

// MARK: - Auth Path

enum AuthPath: String, CaseIterable, Hashable {
    case tosAgreement, signIn, signUp, validateEmail
}

// MARK: - Health Path

enum HealthPath: String, CaseIterable, Hashable {
    case landingPage
}
