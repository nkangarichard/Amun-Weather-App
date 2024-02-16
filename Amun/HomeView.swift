//
//  TestView.swift
//  Amun
//
//  Created by Richard Nkanga on 09/02/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State var sampleData = ["Montreal", "Paris", "poland", "London"]
    @State var locationArray: [String] = []
    @State private var newLocation = "Canada"
    @State private var isEditing = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)
                    .onAppear {
                    }

                ScrollView {
                    VStack {
                        ForEach(viewModel.locations) { locs in

                            HStack {
                                HStack {
                                    if (locs.weatherDataModel?.weather[0].description.lowercased().contains("cloud")) ?? false {
                                        Image("wind")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 44, height: 44, alignment: .center)
                                            .padding(.leading, 10)

                                    } else {
                                        Image("sun")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 44, height: 44, alignment: .center)
                                            .padding(.leading, 10)
                                    }

                                    Text(locs.name)
                                        .font(.custom("Avenir-Black", size: 35))
                                        .foregroundStyle(.text)

                                    Spacer()

                                    if let weatherData = locs.weatherDataModel {
                                        Text("\(Int(weatherData.main.temp))°C")
                                            .font(.custom("Avenir-Black", size: 25))
                                            .foregroundStyle(.text)
                                            .opacity(0.3)
                                            .padding()
                                        //                                Text("Temp: \(weatherData.name)")
                                    } else {
                                        Text("Loading....")
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width, height: 85)
//                                .background(Color(.weatherHolder))

                                .background {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: UIScreen.main.bounds.width, height: 85)
                                            .foregroundStyle(Color(.greyShadow))
                                            .offset(y: 1)
                                            .opacity(0.5)

                                        Rectangle()
                                            .frame(width: UIScreen.main.bounds.width, height: 85)
                                            .foregroundStyle(Color(.weatherHolder))
                                    }
                                }
                                .foregroundColor(.textColorInversed)
//                                .cornerRadius(9)
                                .padding(.bottom, 10)

//                                .padding(.bottom, 14)
                            }
                        }
                    }
                    .onAppear {
                        if locationArray.isEmpty {
                            print("city is  empty")

                            for data in sampleData {
                                locationArray.append(data)
                                let sampleLocationDate = Location(name: data)
                                viewModel.locations.append(sampleLocationDate)
                                viewModel.fetchWeather(for: sampleLocationDate)
                            }
                        } else {
//                            print ("city is not empty")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }

                Spacer()

                Button(action: {
                    locationArray.append("Waterloo")
                    let sampleLocationDate = Location(name: "Waterloo")
                    viewModel.locations.append(sampleLocationDate)
                    viewModel.fetchWeather(for: sampleLocationDate)
                    print("Button Pressed")
                }) {
                    Image(systemName: "plus")
                        .font(Font.custom("Avenir", size: 17.59).weight(.heavy))
                        .frame(width: 70, height: 70, alignment: .center)
//                                       .background(Color.text)
                        .background {
                            ZStack {
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(.greyShadow)
                                    .offset(x: -4, y: 3)

                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(.text)
                            }
                        }
                        .foregroundColor(.textColorInversed)
                        .cornerRadius(9)
                        .padding(.bottom, 30)
                }
                .offset(x: UIScreen.main.bounds.height * 0.17, y: UIScreen.main.bounds.height * 0.37)
            }
            .background(Color.red)
            .navigationTitle("Forecast")
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Text(Date().formatted(.dateTime.day().weekday().month().year()))
                }
                ToolbarItem {
                    Button(action: {
                    }, label: {
                        Text(isEditing ? "Done" : "Edit")
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

                ToolbarItem {
                    Button(action: {
                    }) {
                        Image(systemName: "gear")
                            .font(Font.custom("Avenir", size: 14.59).weight(.heavy))
                            .frame(width: 35, height: 35, alignment: .center)
                            //                                       .background(Color.text)
                            .background {
                                ZStack {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.greyShadow)
                                        .offset(x: -4, y: 3)

                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.text)
                                }
                            }
                            .foregroundColor(.textColorInversed)
                            .cornerRadius(9)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
