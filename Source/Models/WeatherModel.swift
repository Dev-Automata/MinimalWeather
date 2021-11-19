//
// Created by Кирилл Михайлин on 19.11.2021.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double

    var temperatureString: String {
        return String(Int(round(temperature)))
    }

    var pressureString: String {
        return String(pressure)
    }

    var humidityString: String {
        return String(humidity)
    }

    var windSpeedString: String {
        return String(Int(round(windSpeed)))
    }

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
