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
        
        cityTextField.delegate = self
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        cityTextField.changeBottomBorder(for: "bottomLine", to: UIColor(named: K.AssetsColors.textColorMuted))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case K.Segues.toWeatherScreen:
            prepareWeatherScreen(segue)
        default: break
        }
    }

    private var isSubmittedViaReturn = false;

    private func prepareWeatherScreen(_ segue: UIStoryboardSegue) {
        guard let weatherScreen = segue.destination as? WeatherViewController else { return }

        weatherScreen.city = cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func searchSubmitted() {
        if isSubmittedViaReturn {
            performSegue(withIdentifier: K.Segues.toWeatherScreen, sender: self)
        }
    }
}

// MARK: - UITextFieldDelegate
extension CitySelectViewController: UITextFieldDelegate {
    
    @IBAction func citySearchPressed(_ sender: UIButton) {
        isSubmittedViaReturn = false
        cityTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isSubmittedViaReturn = true

        cityTextField.resignFirstResponder()
        cityTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return cityTextField.hasText
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if cityTextField.hasText {
            searchSubmitted()
        }
    }
    
}
