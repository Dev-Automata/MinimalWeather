//
//  GetForecastForCity.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import Foundation
import UIKit

class GetForecastByCity: Request {
    
    init(name: String) {
        super.init(
            path: "/data/2.5/weather",
            method: .get,
            query: [
                URLQueryItem(name: "q", value: name),
                URLQueryItem(name: "units", value: "metric"),
            ]
        )
    }
}
