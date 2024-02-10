//
//  TestView.swift
//  Amun
//
//  Created by Richard Nkanga on 07/02/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var blink = false
    @State private var goToOnboardingScreen = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)

                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 114.5, height: 90.6)
                        .opacity(blink ? 1 : 0)

                        .onAppear {
                            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                                self.blink.toggle()
                            }

                            // Redirect to another view after 3 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                goToOnboardingScreen = true
                                UserDefaults.standard.set(true, forKey: "splashScreenShown")
                            }
                        }
                        .navigationDestination(isPresented: $goToOnboardingScreen) {
                            OnboardingView()
                                .navigationBarBackButtonHidden(true)
                                .ignoresSafeArea(.all)

                        }
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    SplashScreenView()
}
