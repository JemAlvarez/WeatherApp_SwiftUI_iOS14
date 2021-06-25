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
    
    func getLocationName(location: CLLocation, completion: @escaping (CityName) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, _  in
            guard let place = placemarks?.first else {
                return
            }
            
            var cityName = ""
            var stateName = ""
            var countryName = ""
            
            if let city = place.locality {
                cityName = city
            }
            
            if let state = place.administrativeArea {
                stateName = state
            }
            
            if let country = place.isoCountryCode {
                countryName = country
            }
            
            completion(CityName(city: cityName, state: stateName, country: countryName))
        }
    }
    
    func getLocation(_ name: String, completion: @escaping (CLLocation) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemark, _ in
            guard let place = placemark?.first else {
                return
            }
            
            if let city = place.location {
                completion(city)
            }
        }
    }
}
