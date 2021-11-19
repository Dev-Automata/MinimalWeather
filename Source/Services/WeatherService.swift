//
// Created by Кирилл Михайлин on 19.11.2021.
//

import Foundation

protocol WeatherServiceDelegate: AnyObject {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel)
    func didWeatherFailWithError(error: Error)
}

class WeatherService {

   weak var delegate: WeatherServiceDelegate?

   public func getForecastForCity(name city: String) {
       let _ = apiClient.send(request: GetForecastByCity(name: city)) { data, error in
           self.handleResponse(data: data, error: error)
       }
   }

    public func getForecastForLocation(latitude: String, longitude: String) {
        let _ = apiClient.send(request: GetForecastForLocation(latitude: latitude, longitude: longitude)) { data, error in
            self.handleResponse(data: data, error: error)
        }
    }

   private lazy var apiClient = APIClient(host: "api.openweathermap.org", apiKey: ["appid": apiKeyOW])
    
   private func handleResponse(data: Data?, error: Error?) {
       if error != nil {
           self.delegate?.didWeatherFailWithError(error: error!)
       }

       guard let data = data else {
           let errorDomain = "weather_fetching"
           let errorCode = 100
           let errorInfo = [NSLocalizedDescriptionKey: "No results were sent by the server."]

           self.delegate?.didWeatherFailWithError(error: NSError(domain: errorDomain, code: errorCode, userInfo: errorInfo))
           return
       }

       print(String(data: data, encoding: .utf8))

       guard let weather = self.parseJSON(data) else {
           let errorDomain = "weather_fetching"
           let errorCode = 200
           let errorInfo = [NSLocalizedDescriptionKey: "JSON parser error."]

           self.delegate?.didWeatherFailWithError(error: NSError(domain: errorDomain, code: errorCode, userInfo: errorInfo))
           return
       }

       self.delegate?.didUpdateWeather(self, weather: weather)
   }

   private func parseJSON(_ weatherData: Data) -> WeatherModel? {
       let decoder = JSONDecoder()
       do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           let id = decodedData.weather[0].id
           let name = decodedData.name
           let temp = decodedData.main.temp
           let pressure = decodedData.main.pressure
           let humidity = decodedData.main.humidity
           let windSpeed = decodedData.wind.speed

           let weather = WeatherModel(
               conditionId: id,
               cityName: name,
               temperature: temp,
               pressure: pressure,
               humidity: humidity,
               windSpeed: windSpeed
           )
           return weather

       } catch {
           delegate?.didWeatherFailWithError(error: error)
           return nil
       }
   }

   private var apiKeyOW: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "OpenWeather-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'OpenWeather-Info.plist'.")
            }

            let plist = NSDictionary(contentsOfFile: filePath)

            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'OpenWeather-Info.plist'.")
            }

            if (value.starts(with: "_")) {
                fatalError("Set your own API key for OpenWeather in 'OpenWeather-Info.plist' file")
            }

            return value
        }
    }
}
