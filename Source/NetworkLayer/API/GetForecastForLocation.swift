//
// Created by Кирилл Михайлин on 19.11.2021.
//

import Foundation

class GetForecastForLocation: Request {

    init(latitude: String, longitude: String) {
        super.init(
                path: "/data/2.5/weather",
                method: .get,
                query: [
                    URLQueryItem(name: "lat", value: latitude),
                    URLQueryItem(name: "lon", value: longitude),
                    URLQueryItem(name: "units", value: "metric"),
                    URLQueryItem(name: "lang", value: "ru"),
                ]
        )
    }
}
