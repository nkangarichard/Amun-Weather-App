//
//  DetailView.swift
//  Amun
//
//  Created by Richard Nkanga on 19/03/2024.
//

import SwiftUI

struct DetailView: View {
    let location: Location


    @Environment(\.dismiss) var isDismissed

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mma"
        return formatter
    }()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)

                VStack {

                    HStack {
                        Spacer()

                        Button(action: {
                        isDismissed()


                        }, label: {
                            Text("Back")
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
                    .padding(.trailing)







                    if let weatherData = location.weatherDataModel {

    //                    Image(weatherData.weather[0].description.lowercased().contains("rain") ? "rain" :
    //                          weatherData.weather[0].description.lowercased().contains("sun") ? "sun" :
    //                          weatherData.weather[0].description.lowercased().contains("cloud") ? "cloud" :
    //                          weatherData.weather[0].description.lowercased().contains("snow") ? "snow" :
    //                          "sun")
    //                        .resizable()
    //                        .scaledToFit()
    //                        .frame(width: 244, height: 244)





                        Image(weatherData.weather[0].description.lowercased().contains("cloud") ? "wind" : "sun")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 244, height:244)


                        VStack(spacing: -15) {


                            Text(" \(Int(weatherData.main.temp))°")
                                .font(.custom("Avenir-Black", size: 112))
                                                


                            Text("HOT AS HELL")
                                .font(.custom("Avenir-Medium", size: 18))
                                .foregroundStyle(.greyShadow)
                                .opacity(0.5)
                            //                        .padding()


                            HStack {
                                Text("H \(Int(weatherData.main.tempMax))º")
                                    .font(.custom("Avenir-Black", size: 20))

                                Spacer()
                                    .frame(width: 56)

                                Text("L \(Int(weatherData.main.tempMin))º")
                                    .font(.custom("Avenir-Black", size: 20))
                            }
                            .padding()
                        }
                        .padding(.top,-40)


                        Spacer()

                        VStack {
                            Text("Might as well plan a trip to ")
                            Text("hell at this point.")
                        }
                        .font(.custom("Avenir-Medium", size: 18))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .foregroundStyle(.greyShadow)
                        .opacity(0.5)

                        Spacer()

                        VStack(spacing: -5) {
                            Text("\(location.name)")
                                .font(.custom("Avenir-Black", size: 29))

                            Text(Date(), formatter: Self.dateFormatter)
                                .font(.custom("Avenir-Medium", size: 17))

                            .padding()
                        }

                        Spacer()
    //
    //                    Spacer()




                        // Add more weather data here if needed
                    } else {
                        Text("Loading Weather Data...")
                    }
                }

            }
            .navigationBarBackButtonHidden(true)
//            .toolbar{
//
//                ToolbarItem {
//
//                Button(action: {
////                    isPresented.wrappedValue.dismiss()
//
//
//
//                }, label: {
//                    Text("Back")
//                        .font(.custom("Avenir-Medium", size: 10))
//                        .frame(width: 58, height: 27, alignment: .center)
//                        .background(
//                            RoundedRectangle(cornerRadius: 20)
//                                .frame(width: 58, height: 27)
//                                .foregroundStyle(.greyShadow)
//                                .offset(x: -4, y: 4)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .frame(width: 58, height: 27)
//                                        .foregroundStyle(.text)
//                                )
//                        )
//                        .foregroundColor(.textColorInversed)
//                })
//
//                }
//
//
//
//                }
        }
    }
}

#Preview {
//    DetailView(location: Location)
//    let sampleLocation = Location(name: "LONDON")
//    return DetailView(location: sampleLocation)


    let sampleLocation = Location(name: "LONDON")
       sampleLocation.weatherDataModel = WeatherDataModel(
           coord: Coord(lon: 0, lat: 0),
           weather: [Weather(id: 0, main: "Clouds", description: "overcast", icon: "cloud")],
           base: "stations",
           main: Main(temp: 20, feelsLike: 20, tempMin: 15, tempMax: 25, pressure: 1013, humidity: 80),
           visibility: 10000,
           wind: Wind(speed: 5, deg: 180),
           clouds: Clouds(all: 90),
           dt: 1616182264,
           sys: Sys(type: 1, id: 9514, country: "GB", sunrise: 1616158900, sunset: 1616203441),
           timezone: 0,
           id: 2643743,
           name: "London",
           cod: 200
       )
       return DetailView(location: sampleLocation)


}
