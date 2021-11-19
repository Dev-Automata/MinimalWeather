//
//  ViewController.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    let weatherService = WeatherService()
    var city: String?

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherService.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        weatherService.getForecastForCity(name: "Moscow")
    }

    @IBAction func unwindToWeatherScreen(_ unwindSegue: UIStoryboardSegue) {
        guard let city = city else { return }
        weatherService.getForecastForCity(name: city)
    }

    private func updateUIOnWeatherLoad(with data: WeatherModel) {
        cityNameLabel.text = data.cityName
        weatherIcon.image = UIImage(systemName: data.conditionName)
        temperatureLabel.text = data.temperatureString
        pressureLabel.text = data.pressureString
        humidityLabel.text = data.humidityString
        windLabel.text = data.windSpeedString
    }

}

// MARK: - WeatherServiceDelegate
extension WeatherViewController: WeatherServiceDelegate {

    func didUpdateWeather(_ weatherManager: WeatherService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.updateUIOnWeatherLoad(with: weather)
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
