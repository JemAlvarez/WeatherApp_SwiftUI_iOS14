//

import Foundation
import CoreLocation

class CityViewModel: ObservableObject {
    @Published var city: CityModel = CityModel(cityName: "", cityData: miscData.tempCityModel)
    @Published var currentLocationData = CityModel(cityName: "", cityData: miscData.tempCityModel)
    @Published var mapCity = CityModel(cityName: "", cityData: miscData.tempCityModel)
    @Published var unit = "imperial"
    
    func cityRequest(location: CLLocation, save: String) {
        ApiModel().getCity(location: location, unit: unit) { city in
            if save == "main" {
                self.city = city
            } else if save == "current" {
                self.currentLocationData = city
            } else if save == "map" {
                self.mapCity = city
            }
        }
    }
    
    func getWeatherImage(id: Int) -> String {
        var image = ""
        
        switch id {
        case 800:
            image = "clear_sky"
        case 511:
            image = "snow"
        case 500...531:
            image = "rain"
        case 200...232:
            image = "thunderstorm"
        case 300...321:
            image = "shower_rain"
        case 600...622:
            image = "snow"
        case 701...781:
            image = "mist"
        case 801...802:
            image = "few_clouds"
        case 803...804:
            image = "scattered_clouds"
        default:
            image = "clear_sky"
        }
        
        return image
    }
    
    func getTime(stamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(stamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        return formatter.string(from: date)
    }
}
