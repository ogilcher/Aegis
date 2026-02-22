//
//  AppRoot.swift
//  Aegis
//
//  Created by Oliver Gilcher on 2/19/26.
//

import SwiftUI

struct AppRoot: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("Hello World!")
        }
    }
}

#Preview {
    AppRoot()
}
