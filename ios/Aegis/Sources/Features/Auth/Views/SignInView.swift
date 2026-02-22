//
//  SignInView.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/20/26.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack (spacing: 20) {
            Text("Sign In Email")
                .font(.largeTitle.bold())
                .padding()
            
            Spacer()
            
            Group {
                AppTextField("Email", text: $email, type: .email)
                AppTextField("Password", text: $password, type: .password)
            }
            .frame(width: 300)
            
            Spacer()
            
            PrimaryButton("Sign In") {
                
            }
        }
        .frame(height: 350)
    }
}

#Preview {
    SignInView()
}
