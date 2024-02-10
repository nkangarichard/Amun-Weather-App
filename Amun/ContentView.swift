//
//  ContentView.swift
//  Amun
//
//  Created by Richard Nkanga on 05/02/2024.
//

import CoreMotion
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            if UserDefaults.standard.bool(forKey: "splashScreenShown") {
                // Show your main content or home view
                HomeView()
                    .navigationBarBackButtonHidden(true)
                    .ignoresSafeArea(.all)

            } else {
                SplashScreenView()
                    .ignoresSafeArea(.all)
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
