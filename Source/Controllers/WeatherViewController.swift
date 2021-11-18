//
//  ViewController.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    let weatherService = WeatherService()

    @IBOutlet weak var cityNameLabel: UIButton!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherService.delegate = self
    }
    
    @IBAction func cityNamePressed(_ sender: UIButton) {
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        weatherService.getForecastForCity(name: "Moscow")
    }

    @IBAction func themeTogglePressed(_ sender: UIButton) {
    }

}


extension WeatherViewController: WeatherServiceDelegate {

    func didUpdateWeather(_ weatherManager: WeatherService, weather: WeatherModel) {
        print(weather.temperatureString)
        print(weather.windSpeedString)
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
