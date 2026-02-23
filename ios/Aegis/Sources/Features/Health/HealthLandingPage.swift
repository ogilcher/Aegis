//
//  HealthLandingPage.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/23/26.
//

import SwiftUI

struct HealthLandingPage: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @ObservedObject var viewModel: HealthViewModel
    
    var body: some View {
        VStack (spacing: 20) {
            Text("Health Landing page")
                .font(.largeTitle.bold())
        }
    }
}

#Preview {
    HealthLandingPage(viewModel: HealthViewModel())
        .environmentObject(AppCoordinator())
}
