//
//  SignUpView.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/20/26.
//

import SwiftUI

// MARK: - Sign Up View

struct SignUpView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject var viewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack (spacing: 20) {
            Text("Sign Up Email")
                .font(.largeTitle.bold())
            
            Spacer()
            
            Group {
                AppTextField("Email", text: $email, type: .email)
                AppTextField("Password", text: $password, type: .password)
            }
            .frame(width: 300)
            
            Spacer()
            
            PrimaryButton("Continue") { signUp() }
        }
        .frame(height: 350)
    }
    
    func signUp() {
        Task {
            _ = try? await viewModel.signUp(email: email, password: password).get()
        }
        coordinator.push(.auth(.validateEmail))
    }
}

#Preview {
    SignUpView(viewModel: AuthViewModel(engine: AuthenticationEngine()))
        .environmentObject(AppCoordinator())
}
