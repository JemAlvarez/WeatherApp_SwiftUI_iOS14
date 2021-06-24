import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var manager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus = .authorizedWhenInUse
    @Published var coords = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func getLocationName(location: CLLocation, completion: @escaping (String) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, _  in
            guard let place = placemarks?.first else {
                return
            }
            
            var cityName = ""
            
            if let city = place.locality {
                cityName += city
            }
            
            if let state = place.administrativeArea {
                cityName += ", \(state)"
            }
            
            completion(cityName)
        }
    }
}
