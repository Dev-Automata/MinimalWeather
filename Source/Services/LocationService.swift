//
// Created by Кирилл Михайлин on 19.11.2021.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(_ locationService: LocationService, latitude: Double, longitude: Double)
    func didLocationFailWithError(error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    weak var delegate: LocationServiceDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocationOnAppStart() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func requestLocationOnUserDemand() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude

            delegate?.didUpdateLocation(self, latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didLocationFailWithError(error: error)
    }
}
