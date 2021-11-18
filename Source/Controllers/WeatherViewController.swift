//
//  ViewController.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UIButton!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cityNamePressed(_ sender: UIButton) {
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
    }

    @IBAction func themeTogglePressed(_ sender: UIButton) {
    }
}

