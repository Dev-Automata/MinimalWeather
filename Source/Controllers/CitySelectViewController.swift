//
//  WeatherViewController.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import UIKit

class CitySelectViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.addBottomBorder(tag: "bottomLine", color: UIColor(named: K.AssetsColors.textColorBase))
        cityTextField.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        view.endEditing(true)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        cityTextField.changeBottomBorder(for: "bottomLine", to: UIColor(named: K.AssetsColors.textColorBase))
    }

    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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

    func textFieldDidEndEditing(_ textField: UITextField) {
        if cityTextField.hasText {
            searchSubmitted()
        }
    }
    
}
