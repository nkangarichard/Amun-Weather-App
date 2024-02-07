//
//  ContentView.swift
//  Amun
//
//  Created by Richard Nkanga on 05/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)

                VStack {
                    ZStack {
                        Image("sun")
                    }

                    VStack {
                        Text("Know Everything about the weather").font(.custom("Avenir-Black", size: 37))

                        VStack {
                            Text("Start now and learn more about the")
                                .font(.custom("Avenir-Medium", size: 17))

                            HStack(spacing: 5) {
                                Text("local weather")
                                    .font(.custom("Avenir-Black", size: 17))

                                Text("instantly")
                                    .font(.custom("Avenir-Medium", size: 17))
                            }
                        }
                        .opacity(0.5)
                    }
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.text)

                    Button(action: {
                        // code

                    }, label: {
                        Text("Get Started")
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
                }
                .padding()

            }
        .ignoresSafeArea(.all)
        .toolbar{
            ToolbarItem{

                Button(action: {
                    // code

                }, label: {
                    Text("Skip")
                        .font(.custom("Avenir-Medum", size: 10))
                        .frame(width: 58, height: 27, alignment: .center)

                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 58, height: 27)
                                    .foregroundStyle(.greyShadow)
                                    .offset(x: -6, y: 6)

                                RoundedRectangle(cornerRadius: 10)
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

}

#Preview {
    ContentView()
}
