//
// Created by Кирилл Михайлин on 19.11.2021.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(_ locationService: LocationService, latitude: Double, longitude: Double)
    func didLocationFailWithError(error: Error)
    func didAuthorizeRejected()
}

class LocationService: NSObject {

    private let locationManager = CLLocationManager()

    weak var delegate: LocationServiceDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    public func requestLocationOnAppStart() {
        locationManager.requestWhenInUseAuthorization()
    }

    public func requestLocationOnUserDemand() {
        locationManager.requestLocation()
    }
    
    private func handleAuthStatusChange(on status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            fallthrough
        case .denied:
            delegate?.didAuthorizeRejected()
            break
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            fallthrough
        case .authorized:
            locationManager.requestLocation()
            break
        default: break
        }
    }

}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    // TODO: maybe locationManagerDidChangeAuthorization (since iOS 14)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthStatusChange(on: status)
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
