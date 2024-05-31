//
//  TestView.swift
//  Amun
//
//  Created by Richard Nkanga on 09/02/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel.shared
//    @State private var sampleData = ["Montreal", "Paris", "Poland", "London"]
    @State private var sampleData = ["Montreal"]
    @State private var locationArray: [String] = []
    @State private var dragOffset: [UUID: CGSize] = [:]
    @State private var opac: [UUID: Double] = [:]
    @State private var deleteButtonopac: [UUID: Double] = [:]
    @State var buttonOffset: [UUID: CGSize] = [:]
    @State private var isEditing = false
    @State var isButtonVisible: [UUID: Bool] = [:]
    @State private var showAddLocationSheet = false
    @State private var showSettingsSheet = false
    @State private var unit: String = "ºC"

    @State private var showError = false


    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)

                ScrollView {
                    VStack {


                        ForEach(viewModel.locations) { locs in

                            HStack {
                                NavigationLink(destination: DetailView(location: locs)) {
//                                    HStack {
                                    HStack {
                                        Image(locs.weatherDataModel?.weather[0].description.lowercased().contains("cloud") ?? false ? "wind" : "sun")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60)
                                            .padding(.leading, 10)
                                            .padding(.trailing, 10)

                                        Text(locs.name)
                                            .font(.custom("Avenir-Black", size: 35))
                                            .foregroundStyle(.text)

                                        Spacer()

                                        if let weatherData = locs.weatherDataModel {
                                            Text("\(Int(weatherData.main.temp))" + "\(unit)")
                                                .font(.custom("Avenir-Black", size: 25))
                                                .foregroundStyle(.text)
                                                .opacity(0.3)
                                                .padding()
                                        } else {
                                            //                                            Text("Loading....")
                                        }
                                    }
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
                                    .padding(.bottom, 10)
                                    .opacity(opac[locs.id] ?? 1.0)
                                    .overlay {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: UIScreen.main.bounds.width, height: 85)
                                                .offset(x: 0, y: -4)
                                                .foregroundStyle(Color(.dangerRed))

                                            Text("Delete")
                                                .font(.custom("Avenir-Black", size: 35))
                                                .foregroundStyle(.text)
                                        }
                                        .opacity(deleteButtonopac[locs.id] ?? 0)
                                        .onTapGesture {
                                            if let index = viewModel.locations.firstIndex(of: locs) {
                                                withAnimation(.easeInOut) {
                                                    dragOffset[locs.id] = CGSize(width: UIScreen.main.bounds.width * -1.0, height: 0)

                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                        viewModel.locations.remove(at: index)
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    .offset(dragOffset[locs.id] ?? .zero)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in

                                                if value.translation.width < -10 {
                                                    withAnimation(.easeInOut) {
                                                        dragOffset[locs.id] = CGSize(width: UIScreen.main.bounds.width * -0.15, height: 0)
                                                        opac[locs.id] = 0.5

                                                        withAnimation(.easeInOut) {
                                                            deleteButtonopac[locs.id] = 0.9 // Adjust the opacity value as needed
                                                        }
                                                    }
                                                }
                                            }

                                            .onEnded { value in

                                                withAnimation(.easeInOut) {
                                                    if value.translation.width > 10 {
                                                        dragOffset[locs.id] = CGSize(width: UIScreen.main.bounds.width * 0, height: 0)
                                                        opac[locs.id] = 1.0
//                                                            isButtonVisible[locs.id] = true

                                                        withAnimation(.easeInOut) {
                                                            deleteButtonopac[locs.id] = 0 // Adjust the opacity value as needed
                                                        }
                                                    }
                                                }
                                            }
                                    )
//                                    .onChange(of: viewModel.selectedUnit) { newValue in
//                                        switch newValue {
//                                        case "imperial":
//                                            unit = "ºF"
//                                            print("It is imperial")
//                                        case "metric":
//                                            unit = "ºC"
//                                            print("It is metric")
//                                        case "standard":
//                                            unit = "ºK"
//                                            print("It is standard")
//                                        default:
//                                            break
//                                        }
//                                    }

                                    .onChange(of: viewModel.selectedUnit) { _, newValue in
                                        switch newValue {
                                        case "imperial":
                                            unit = "ºF"
                                            print("It is imperial")
                                        case "metric":
                                            unit = "ºC"
                                            print("It is metric")
                                        case "standard":
                                            unit = "ºK"
                                            print("It is standard")
                                        default:
                                            break
                                        }
                                    }
                                }
                                .disabled(false)
                                .navigationBarBackButtonHidden(true)
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 86)
                        }
                    }
                    .padding()
                    .onAppear {
                        if locationArray.isEmpty {
                            print("city is  empty")
                            for data in sampleData {
                                locationArray.append(data)
                                let sampleLocationDate = Location(name: data)
                                viewModel.locations.append(sampleLocationDate)
                                viewModel.fetchWeather(for: sampleLocationDate)
                            }
                        }
                    }
                }

                Button(action: {
                    showAddLocationSheet.toggle()

//                    locationArray.append("Waterloo")
//                    let sampleLocationDate = Location(name: "Waterloo")
//                    viewModel.locations.append(sampleLocationDate)
//                    viewModel.fetchWeather(for: sampleLocationDate)
//                    print("Button Pressed")

                }) {
                    Image(systemName: "plus")
                        .font(Font.custom("Avenir", size: 17.59).weight(.heavy))
                        .frame(width: 70, height: 70, alignment: .center)
                        .background(
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundStyle(.greyShadow)
                                .offset(x: -4, y: 3)
                                .overlay(
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(.text)
                                )
                        )
                        .foregroundColor(.textColorInversed)
                        .cornerRadius(9)
                        .padding(.bottom, 30)
                }
                .offset(x: UIScreen.main.bounds.width * 0.37, y: UIScreen.main.bounds.height * 0.37)
                .disabled(isEditing)
                .sheet(isPresented: $showAddLocationSheet, content: {
                    InputView(viewModel: viewModel)
                        .presentationDetents([.large, .medium])
                        .interactiveDismissDisabled()

                })
            }
            .background(Color.red)
            .navigationTitle("Forecast")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 2) {
                        Text(Date().formatted(.dateTime.day().weekday().month()))
                        Text(",")
                        Text(Date().formatted(.dateTime.year(.twoDigits)))
                    }
                }
                ToolbarItem {
                    Button(action: {
                        isEditing.toggle()

                        withAnimation(.easeInOut) {
                            for locs in viewModel.locations {
                                dragOffset[locs.id] = isEditing ? CGSize(width: UIScreen.main.bounds.width * -0.15, height: 0) : .zero
                                opac[locs.id] = isEditing ? 0.5 : 1.0
                                deleteButtonopac[locs.id] = isEditing ? 0.9 : 0

                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//                                    buttonOffset[locs.id] = isEditing ? CGSize(width: -10, height: -3) : .zero

                                    withAnimation(.easeInOut) {
                                        isButtonVisible[locs.id] = isEditing ? true : false
                                    }
                                }
                            }
                        }

                    }, label: {
                        Text(isEditing ? "Done" : "Edit")
                            .font(.custom("Avenir-Medium", size: 10))
                            .frame(width: 58, height: 27, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 58, height: 27)
                                    .foregroundStyle(.greyShadow)
                                    .offset(x: -4, y: 4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 58, height: 27)
                                            .foregroundStyle(.text)
                                    )
                            )
                            .foregroundColor(.textColorInversed)
                    })
                }
                ToolbarItem {
                    Button(action: {
                        showSettingsSheet.toggle()

                    }) {
                        Image(systemName: "gear")
                            .font(Font.custom("Avenir", size: 14.59).weight(.heavy))
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
                            .sheet(isPresented: $showSettingsSheet, content: {
                                SettingsView(viewModel: viewModel)
                                    .presentationDetents([.large, .medium])
                                    .interactiveDismissDisabled()

                            })
                    }
                }
            }



        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
