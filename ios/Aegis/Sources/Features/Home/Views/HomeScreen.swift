//
//  HomeScreen.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/20/26.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("Home Screen")
                .font(.largeTitle.bold())
            
            
        }
    }
}

#Preview {
    HomeScreen()
}
