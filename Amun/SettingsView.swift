//
//  SettingsView.swift
//  Amun
//
//  Created by Richard Nkanga on 05/04/2024.
//

import SwiftUI

struct MetricHolder: Identifiable {
    let id = UUID()
    let Symbol: String
    let name: String
}

struct altAppIcon: Identifiable {
    let id = UUID()
    let imageName: String
    let description: String
}

struct SettingsView: View {
    let metricSymbols: [MetricHolder] = [
        MetricHolder(Symbol: "ºC", name: "metric"),
        MetricHolder(Symbol: "ºF", name: "imperial"),
        MetricHolder(Symbol: "K", name: "standard"),
    ]

    let icon: [altAppIcon] = [
        altAppIcon(imageName: "AppIcon-Default", description: "Default"),
        altAppIcon(imageName: "AppIcon-Sun", description: "Sun"),
        altAppIcon(imageName: "AppIcon-Cloudy", description: "Cloudy"),
    ]

    @ObservedObject var viewModel = WeatherViewModel.shared
    @Namespace var selectionAnimation
    @State var CurrentIcon: String = "AppIcon-Default"
    @State var currentMetric: String = "ºC"
    @State var cirlceSeletorVisbility: Bool = true
    @State private var currentIndex = 0
    @State var snesory = false

    @Environment(\.dismiss) var dismiss

    // MARK: - SECTION: HEADER

    private let alternateAppIcons: [String] = [
        "AppIcon-Cloudy",
        "AppIcon-Sun",
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)

                VStack(spacing: 30) {
                    VStack {
                        HStack(alignment: .top) {
                            Text("Unit")
                                .foregroundStyle(.text)
                                .opacity(0.5)

                            Spacer() // Pushes the Text to the left edge of the screen
                        }
                        .padding(.horizontal)

                        HStack {
                            ForEach(metricSymbols.indices, id: \.self) { i in

                                let symbol = metricSymbols[i].Symbol
                                let name = metricSymbols[i].name

                                VStack {
                                    if currentMetric == symbol {
                                        Circle()
                                            .frame(height: 5)
                                            .foregroundStyle(.text)
                                    }

                                    Text("\(symbol)")
                                        .font(.custom(currentMetric == symbol ? "Avenir-Black" : "Avenir-Black", size: currentMetric == symbol ? 39 : 30))
                                        .foregroundStyle(.text)

                                    Text("\(name)")
                                        .font(.custom(currentMetric == symbol ? "Poppins-Medium" : "Poppins-Black", size: currentMetric == symbol ? 12 : 11))
                                        .foregroundStyle(.text)
                                }

                                .padding()
                                .frame(width: 117, height: 108)
                                .background {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 117, height: 108)
                                            .foregroundStyle(Color(.greyShadow))
                                            .offset(x: 0, y: currentMetric == symbol ? 3 : 1)
                                            //                                        .offset(y: 1)
                                            .opacity(currentMetric == symbol ? 1 : 0.4)

                                        Rectangle()
                                            .frame(width: 117, height: 108)
                                            .foregroundStyle(Color(.weatherHolder))
                                    }
                                }
                                .onTapGesture {
                                    currentMetric = symbol
                                    viewModel.selectedUnit = name
//                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    snesory.toggle()


                                    print("The View Model selected unit is \(viewModel.selectedUnit)")
                                }

                                .sensoryFeedback(.impact, trigger: snesory)
                            }
                        }
                    }

                    VStack(spacing: 20) {
                        HStack(alignment: .top) {
                            Text("Icons")
                                .foregroundStyle(.text)
                                .opacity(0.5)

                            Spacer()

                            // Pushes the Text to the left edge of the screen
                        }

                        VStack {
                            HStack {
                                ForEach(icon.indices, id: \.self) { c in

                                    let iconImage = icon[c].imageName
//                                        let desc = icon[c].description

                                    VStack {
                                        Image("\(iconImage)-Preview")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                            )
                                            .onTapGesture {
                                                CurrentIcon = iconImage

                                                UIApplication.shared.setAlternateIconName(iconImage) { error in
                                                    if error != nil {
                                                        print("Icon channge Failed")
                                                    } else {
                                                        print("Success")
                                                    }
                                                }
                                            }.sensoryFeedback(.impact, trigger: snesory)

                                        if CurrentIcon == iconImage {
                                            Circle()
                                                .frame(height: 5)
                                                .foregroundStyle(.text)
                                        }
                                    }
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                            .background {
                                ZStack {
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width * 0.93, height: 108)
                                        .foregroundStyle(Color(.greyShadow))
                                        .offset(y: 1)
                                        .opacity(0.5)

                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width * 0.93, height: 108)
                                        .foregroundStyle(Color(.weatherHolder))
                                }
                            }

                            Text("Select your favorite icon from the options above.")
                                .padding(.top)
                                .font(.footnote)

                                .foregroundStyle(.text)
                                .opacity(0.5)
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationTitle("Settings")
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
        }
    }
}

#Preview {
    SettingsView(viewModel: WeatherViewModel())
}
