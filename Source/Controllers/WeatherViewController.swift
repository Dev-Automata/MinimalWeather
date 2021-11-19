//
//  ViewController.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    let weatherService = WeatherService()
    let locationService = LocationService()

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
        locationService.delegate = self

        locationService.requestLocationOnAppStart()
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationService.requestLocationOnUserDemand()
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

    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.updateUIOnWeatherLoad(with: weather)
        }
    }

    func didWeatherFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - LocationServiceDelegate
extension WeatherViewController: LocationServiceDelegate {
    func didUpdateLocation(_ locationService: LocationService, latitude: Double, longitude: Double) {
        weatherService.getForecastForLocation(latitude: String(latitude), longitude: String(longitude))
    }

    func didLocationFailWithError(error: Error) {
        print("Location manager error: \(error)")
        performSegue(withIdentifier: K.Segues.toCitySelectScreen, sender: self)
    }

}
