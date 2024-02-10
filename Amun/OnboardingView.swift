//
//  OnboardingView.swift
//  Amun
//
//  Created by Richard Nkanga on 09/02/2024.
//

import CoreMotion
import SwiftUI

struct OnboardingPageModel: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

struct OnboardingView: View {
    let page: [OnboardingPageModel] = [
        OnboardingPageModel(title: "Know Everything about the Weather", image: "sun"),
        OnboardingPageModel(title: "Weather Forecast with Some Humour", image: "wind"),
        OnboardingPageModel(title: "Weather Forecast with Some Humour", image: "lightning"),
    ]

    @State private var currentIndex = 0
    @State private var navigateToTestView = false

    @State private var rotationAngle: Double = 0.0
    let motionManager = CMMotionManager()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)

                VStack {
                    //                    Text("Current Index = \(currentIndex)").font(.custom("Avenir-Black", size: 17))


//                    Spacer()
//                        .frame(height: 10)

                    TabView(selection: $currentIndex) {
                        ForEach(page.indices, id: \.self) { p in
                            VStack {
                                    Image(page[p].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 300)
                                        .rotationEffect(.degrees(rotationAngle))
                                        .onAppear {
                                            startGyroscopeUpdates()
                                        }
                                        .onDisappear {
                                            stopGyroscopeUpdates()
                                        }


                                VStack(spacing: 5) {
                                    Text(page[p].title).font(.custom("Avenir-Black", size: 37))
                                        .lineLimit(nil)
                                        //                                        .minimumScaleFactor(0.3)
                                        .fixedSize(horizontal: false, vertical: true)

                                    VStack {
                                        Text("Start now and learn more about the")
                                            .font(.custom("Avenir-Medium", size: 17))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)

                                        HStack(spacing: 5) {
                                            Text("local weather")
                                                .font(.custom("Avenir-Black", size: 17))

                                            Text("instantly")
                                                .font(.custom("Avenir-Medium", size: 17))
                                        }
                                    }
                                    .opacity(0.5)
                                }
                            }
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.text)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                    .frame(height: 500)
                    .frame(height: UIScreen.main.bounds.height * 0.7)
//                    .background(Color.blue)


                    Spacer()
                        .frame(height: 21)

                    Button(action: {
                        if currentIndex < page.count - 1 {
                            currentIndex += 1
                        } else {
                            navigateToTestView = true
                        }

                    }, label: {
                        Text(currentIndex < page.count - 1 ? "Next" : "Get Started")
                            .font(.custom("Avenir-Black", size: 17))
                            .frame(width: 260, height: 60, alignment: .center)

                            .background {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 260, height: 60)
                                        .foregroundStyle(.greyShadow)
                                        .offset(x: -6, y: 6)

                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 260, height: 60)
                                        .foregroundStyle(.text)
                                }
                            }
                            .foregroundColor(.textColorInversed)



                    })
                    .navigationDestination(isPresented: $navigateToTestView) {
                        HomeView()
                            .navigationBarBackButtonHidden(true)
                    }
//                    Spacer()

                }

            }
            .ignoresSafeArea(.all)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        // code

                    }, label: {
                        Text("Skip")
                            .font(.custom("Avenir-Medum", size: 10))
                            .frame(width: 58, height: 27, alignment: .center)

                            .background {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 58, height: 27)
                                        .foregroundStyle(.greyShadow)
                                        .offset(x: -4, y: 4)

                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 58, height: 27)
                                        .foregroundStyle(.text)
                                }
                            }
                            .foregroundColor(.textColorInversed)

                    })
                }
            }
        }
    }

    func startGyroscopeUpdates() {
        guard motionManager.isGyroAvailable else {
            print("Gyroscope is not available.")
            return
        }

        motionManager.gyroUpdateInterval = 0.1
        motionManager.startGyroUpdates(to: .main) { data, _ in
            guard let data = data else { return }

            // Use rotation data to rotate the image
            let rotationRate = data.rotationRate
            let rotationAngle = atan2(rotationRate.y, rotationRate.x) * 90 / .pi

            withAnimation {
                self.rotationAngle = rotationAngle
            }
        }
    }

    func stopGyroscopeUpdates() {
        if motionManager.isGyroActive {
            motionManager.stopGyroUpdates()
        }
    }
}

#Preview {
    OnboardingView()
}
