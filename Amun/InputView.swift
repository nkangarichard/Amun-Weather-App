//
//  InputView.swift
//  Amun
//
//  Created by Richard Nkanga on 25/03/2024.
//

import SwiftUI

struct InputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var locationName = ""

    @ObservedObject var viewModel: WeatherViewModel
    @State private var locationArray: [String] = []
    @State private var showError = false
    @State private var displayError = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)
                VStack(spacing: 35) {
                    TextField("Name of City or Country", text: $locationName)
                        .padding()
                        .frame(width: 350, height: 67)
                        .background {
                            ZStack {
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width - 40, height: 85)
                                    .foregroundStyle(Color(.greyShadow))
                                    .offset(y: 1)

                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width - 40, height: 85)
                                    .foregroundStyle(Color(.weatherHolder))
                            }
                        }
                        .padding(.bottom, 15)
                        .shadow(color: .black.opacity(0.1), radius: 30, x: 0, y: 5)

                    Button(action: {
                        print("Button Pressed")

//                        if !locationName.isEmpty {
//                            let userInput = Location(name: locationName)
//                            viewModel.fetchWeather(for: userInput)
//                            locationArray.append(locationName) // Add valid location name to array
//                            viewModel.locations.append(userInput)
//                            locationName = ""
//
//                            if showError == true {
//                                print("Error showin")
//
//                            } else {
//                                locationArray.append(locationName)
//                                viewModel.locations.append(userInput)
//
//                                print("No showin")
//                            }
//                        }


                        if !locationName.isEmpty {
                            let userInput = Location(name: locationName)

                            // Call fetchWeather to fetch weather data
                            viewModel.fetchWeather(for: userInput)


                            if showError {
//                                    locationArray.append(userInput.name)


                                print("Nothing to append to arrays")

                            } else {


                                
                                locationArray.append(locationName)
                                viewModel.locations.append(userInput)
                                locationName = ""



                            }
                        }













                    }, label: {
                        Text("Add")
                            .font(.custom("Avenir-Black", size: 17))
                            .frame(width: 260, height: 60, alignment: .center)
                            .opacity(locationName.isEmpty ? 0.6 : 1.0)

                            .background {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 260, height: 60)
                                        .foregroundStyle(.greyShadow)
                                        .offset(x: -6, y: 6)
                                        .opacity(locationName.isEmpty ? 0.6 : 1.0)

                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 260, height: 60)
                                        .foregroundStyle(.text)
                                        .opacity(locationName.isEmpty ? 0.6 : 1.0)
                                }
                            }
                            .foregroundColor(.textColorInversed)
                            .disabled(locationName.isEmpty ? true : false)
                            .opacity(locationName.isEmpty ? 0.6 : 1.0)

                    })

                    Spacer()

                    ForEach(locationArray, id: \.self) { locs in

                        Text(locs)
                            .font(.custom("Avenir-Black", size: 20))
                            .foregroundColor(.white)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Add Loacation")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        dismiss()

                    }) {
                        Image(systemName: "xmark")
                            .font(Font.custom("Avenir", size: 10.59).weight(.heavy))
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(
                                ZStack {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.greyShadow)
                                        .offset(x: -4, y: 3)

                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.text)
                                }
                            )
                            .foregroundColor(.textColorInversed)
                            .cornerRadius(9)
                    }
                }
            }

//            .overlay(
//                showError ?
//                    ErrorPopupView(errorMessage: "The location 'Invalid' could not be found.")
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
//                    : nil
//

            .onChange(of: viewModel.errorMessage) { oldValue, newValue in
                if let errorMessage = newValue, !errorMessage.isEmpty {
                    showError = true

                    locationName = ""

                    print("OldValue: \(oldValue)")
                    print("NewValue: \(newValue as Any)")

                    print("Current Error MEssage: \(String(describing: viewModel.errorMessage))")
                }
            }

            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK")) {
                        viewModel.errorMessage = "" // Clear the error message
                        showError = false // Dismiss the alert
                    }
                )
            }
        }
    }
}

#Preview {
    InputView(viewModel: WeatherViewModel())
}
