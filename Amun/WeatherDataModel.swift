//
//  WeatherDataModel.swift
//  Amun
//
//  Created by Richard Nkanga on 10/02/2024.
//

import Foundation

//
//  WeatherDataModel.swift
//  Nkanga_Richard_8893021_lab8
//
//  Created by Richard Nkanga on 22/07/2023.
//

import Foundation

// MARK: - Welcome

struct WeatherDataModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds

struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord

struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys

struct Sys: Codable {
    let type, id: Int?
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

class Location: ObservableObject, Identifiable, Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name
        // Add comparisons for other properties if needed
    }

    let id = UUID()
    @Published var name: String
    @Published var weatherDataModel: WeatherDataModel?

    init(name: String) {
        self.name = name
    }
}

class WeatherViewModel: ObservableObject {
    static let shared = WeatherViewModel()

    @Published var locations: [Location] = []
    @Published var selectedUnit = "metric" {
        didSet {
            refreshWeatherData()
        }
    }

    @Published var errorMessage: String?
//    @Published var errorMessage = "test message"
    @Published var showError:Bool?
//    Published  var selectedUnit = false

    func fetchWeather(for location: Location) {
        // Implement API request to OpenWeatherMap using URLSession
        // You'll need to replace "YOUR_API_KEY" with your actual OpenWeatherMap API key
        let apiKey = "1338480c47f9e79d9a96b5c589d7fc86"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(location.name)&appid=\(apiKey)&units=\(selectedUnit)"
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=mexico&appid=\(apiKey)"

        guard let url = URL(string: urlString) else { 

            return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch data"
                    self.refreshUI()
                }

                return
            }

            do {
                let decodedData = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                DispatchQueue.main.async {
                    location.weatherDataModel = decodedData

                    self.errorMessage = nil

                    self.refreshUI()
//                    self.locations.append(location)
                    print("Weather data fetched successfully: \(decodedData)")
                }
            } catch {
                self.errorMessage = "Error decoding weather data: \(error.localizedDescription)"
//                self.errorMessage = "Error decoding weather data: \(error)"
                print("Error decoding weather data: \(error)")
//                self.refreshUI()
//                self.showError.toggle()
                self.showError = true
            }

        }.resume()
    }

    func refreshUI() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }

    func refreshWeatherData() {
        for location in locations {
            fetchWeather(for: location)
        }
    }
}
