//
// Created by Кирилл Михайлин on 19.11.2021.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
}
