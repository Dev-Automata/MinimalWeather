//
// Created by Кирилл Михайлин on 19.11.2021.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let description: String
    let temperature: Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double

    var temperatureString: String {
        return String(temperature.rounded(toPlaces: 1))
    }

    var pressureString: String {
        let mmHg = Converter.shared.convertPressure(hPa: pressure)
        return String(mmHg)
    }

    var humidityString: String {
        return String(humidity)
    }

    var windSpeedString: String {
        return String(windSpeed.rounded(toPlaces: 1))
    }

    var conditionName: String {
        switch conditionId {

       // @see https://openweathermap.org/weather-conditions
       // Group 2xx: Thunderstorm
        case 200...202:
            return "cloud.bolt.rain"
        case 210...232:
            return "cloud.bolt"

        // Group 3xx: Drizzle
        case 300...321:
            return "cloud.drizzle"

        // Group 5xx: Rain
        case 500...501:
            return "cloud.sun.rain"
        case 502...504:
            return "cloud.rain"
        case 511:
            return "snowflake.circle"
        case 521...531:
            return "cloud.heavyrain.fill"

        // Group 6xx: Snow
        case 600...601:
            return "cloud.snow"
        case 602:
            return "snowflake"
        case 611...622:
            return "cloud.sleet"

        // Group 7xx: Atmosphere
        case 701:
            return "cloud.fog"
        case 711:
            return "smoke"
        case 721:
            return "sun.haze"
        case 731:
            return "sun.dust"
        case 741:
            return "cloud.fog"
        case 751...762:
            return "aqua.min"
        case 771...781:
            return "tropicalstorm"

        // Group 800: Clear
        case 800:
            return "sun.max"

        // Group 80x: Clouds
        case 801:
            return "sun.min"
        case 802:
            return "cloud.sun"
        case 803...804:
            return "cloud"

        default:
            return "cloud"
        }
    }
}
