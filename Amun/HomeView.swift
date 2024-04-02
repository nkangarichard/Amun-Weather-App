//
//  TestView.swift
//  Amun
//
//  Created by Richard Nkanga on 09/02/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var sampleData = ["Montreal", "Paris", "Poland", "London"]
    @State private var locationArray: [String] = []
    @State private var dragOffset: [UUID: CGSize] = [:]
    @State private var opac: [UUID: Double] = [:]
    @State var buttonOffset: [UUID: CGSize] = [:]
    @State private var isEditing = false
    @State var isButtonVisible: [UUID: Bool] = [:]
    @State private var showAddLocationSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)

                ScrollView {
                    VStack {
                        ForEach(viewModel.locations) { locs in
                            NavigationLink(destination: DetailView(location: locs)){

                                
                                HStack(spacing: -40) {
                                    HStack {
                                        Image(locs.weatherDataModel?.weather[0].description.lowercased().contains("cloud") ?? false ? "wind" : "sun")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .padding(.leading, 20)
                                            .padding(.trailing, 10)
                                        
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
                                        } else {
                                            Text("Loading....")
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
                                    //                                .opacity(isEditing ? 0.5 : 1)
                                    .opacity(opac[locs.id] ?? 1.0)
                                    .offset(dragOffset[locs.id] ?? .zero)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                //                                            if !isEditing {
                                                if value.translation.width < -10 {
                                                    
                                                    withAnimation(.easeInOut) {
                                                        
                                                        dragOffset[locs.id] = CGSize(width: UIScreen.main.bounds.width * -0.15, height: 0)
                                                        opac[locs.id] = 0.5 // Adjust opacity here
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                }
                                            }
                                        
                                            .onEnded { value in
                                                
                                                
                                                
                                                withAnimation(.easeInOut) {
                                                    
                                                    
                                                    
                                                    if value.translation.width > 10 {
                                                        dragOffset[locs.id] = CGSize(width: UIScreen.main.bounds.width * 0, height: 0)
                                                        opac[locs.id] = 1.0
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                        
                                    )
                                    
                                    if isButtonVisible[locs.id] ?? false {
                                        Button(action: {
                                            if let index = viewModel.locations.firstIndex(of: locs) {
                                                
                                                //                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                //                                                withAnimation(.easeInOut)  {
                                                viewModel.locations.remove(at: index)
                                                
                                                
                                                //                                                }
                                                //                                            }
                                                
                                                
                                            }
                                            
                                        }, label: {
                                            Text("Delete")
                                                .font(.custom("Avenir-Medium", size: 14))
                                                .frame(width: 58, height: .infinity, alignment: .center)
                                                .foregroundStyle(Color(.white))
                                                .background(
                                                    RoundedRectangle(cornerRadius: 0)
                                                        .frame(width: 58, height: 85)
                                                        .foregroundStyle(Color(.dangerRed))
                                                )
                                                .offset(dragOffset[locs.id] ?? .zero)
                                                .offset(x: 60, y: -4.5)
                                                .foregroundColor(.textColorInversed)
                                                .opacity(dragOffset[locs.id]?.width == -100 ? 0 : 1)
                                            
                                        })
                                        //                                    .transition(.opacity)
                                    }
                                }
                                
                            }
                            .navigationBarBackButtonHidden(true)
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
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }

                Spacer()

                Button(action: {

                    showAddLocationSheet.toggle()


                    locationArray.append("Waterloo")
                    let sampleLocationDate = Location(name: "Waterloo")
                    viewModel.locations.append(sampleLocationDate)
                    viewModel.fetchWeather(for: sampleLocationDate)
                    print("Button Pressed")

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

                    InputView()

                        .presentationDetents([.large, .medium])
                        .interactiveDismissDisabled()

                })
            }
            .background(Color.red)
            .navigationTitle("Forecast")
            .toolbar {


                ToolbarItem(placement: .topBarLeading) {
                    Text(Date().formatted(.dateTime.day().weekday().month().year()))
                }
                ToolbarItem {
                    Button(action: {
                        isEditing.toggle()

                        withAnimation(.easeInOut) {
                            for locs in viewModel.locations {
                                dragOffset[locs.id] = isEditing ? CGSize(width: UIScreen.main.bounds.width * -0.15, height: 0) : .zero
                                opac[locs.id] = isEditing ? 0.5 : 1.0

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
                        isEditing.toggle()

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
