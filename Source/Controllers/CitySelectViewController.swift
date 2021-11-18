//
//  WeatherViewController.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import UIKit

class CitySelectViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        cityTextField.addBottomBorder(tag: "bottomLine", color: UIColor(named: K.AssetsColors.textColorBase))
    }
    
    
    @IBAction func citySearchPressed(_ sender: UIButton) {
//        cityTextField.changeBottomBorder(for: "bottomLine", to: UIColor(named: K.AssetsColors.textColorMuted))
    }
    
}
