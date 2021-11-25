//
//  Constants.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

enum K {

    enum AssetsColors {
        static let textColorBase = "textColorBase"
        static let textColorMuted = "textColorMuted"
    }
    
    enum Screens {
        static let weatherScreen = "WeatherScreen"
        static let CitySelectScreen = "CitySelectScreen"
    }

    enum Segues {
        static let toCitySelectScreen = "toCitySelectScreen"
        static let toWeatherScreen = "toWeatherScreen"
    }

    enum StorageKeys {
        static let city = "city"
    }
}
