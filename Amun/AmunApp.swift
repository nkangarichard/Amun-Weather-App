//
//  AmunApp.swift
//  Amun
//
//  Created by Richard Nkanga on 05/02/2024.
//

import SwiftUI

@main
struct AmunApp: App {
    @AppStorage("onboardingShown") var onboardingShown: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
//            OnboardingView()
        }
    }
}
