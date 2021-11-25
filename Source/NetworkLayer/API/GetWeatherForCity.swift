//
//  GetWeatherForCity.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import Foundation
import UIKit

class GetWeatherForCity: Request {
    
    init(name: String, lang: String) {
        super.init(
            path: "/data/2.5/weather",
            method: .get,
            query: [
                URLQueryItem(name: "q", value: name),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: lang),
            ]
        )
    }
}
