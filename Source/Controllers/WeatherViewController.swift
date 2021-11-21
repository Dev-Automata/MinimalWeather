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
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var citySelectButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService.delegate = self
        locationService.delegate = self
        
        locationService.requestLocationOnAppStart()
        
        if AppData.city != "" {
            weatherService.getWeatherForCity(name: AppData.city)
        }
        
        weatherDescriptionLabel.text = weatherDescriptionLabel.text?.uppercased()
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationService.requestLocationOnUserDemand()
    }
    
    @IBAction func unwindToWeatherScreen(_ unwindSegue: UIStoryboardSegue) {
        guard let city = city else { return }
        weatherService.getWeatherForCity(name: city)
    }
    
    private func updateUIOnWeatherLoad(with data: WeatherModel) {
        cityNameLabel.text = data.cityName
        weatherDescriptionLabel.text = data.description.uppercased();
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
        AppData.city = weather.cityName
        
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
    func didAuthorizeRejected() {
        print("Location manager not authorized.")
        
        if AppData.city != "" {
            city = AppData.city
            weatherService.getWeatherForCity(name: city!)
        } else {
            performSegue(withIdentifier: K.Segues.toCitySelectScreen, sender: self)
        }
    }
    
    func didUpdateLocation(_ locationService: LocationService, latitude: Double, longitude: Double) {
        weatherService.getWeatherForLocation(latitude: String(latitude), longitude: String(longitude))
    }
    
    func didLocationFailWithError(error: Error) {
        print("Location manager error: \(error)")
        performSegue(withIdentifier: K.Segues.toCitySelectScreen, sender: self)
    }
    
}
extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    }
