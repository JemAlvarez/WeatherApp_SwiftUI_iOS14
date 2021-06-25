//

import Foundation
import CoreLocation
import CoreData

class CityViewModel: ObservableObject {
    @Published var mainCity = miscData.tempCityModel
    @Published var currentLocationCity = miscData.tempCityModel
    @Published var mapCity = miscData.tempCityModel
    @Published var searchCity = miscData.tempCityModel
    @Published var savedCities: [CityModel] = []
    @Published var unit = "imperial"
    
    func cityRequest(location: CLLocation, save: String) {
        ApiModel().getCity(location: location, unit: unit) { city in
            if save == "main" {
                self.mainCity = city
            } else if save == "current" {
                self.currentLocationCity = city
            } else if save == "map" {
                self.mapCity = city
            } else if save == "search" {
                self.searchCity = city
            } else if save == "saved" {
                self.savedCities.append(city)
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
    
    func getTime(stamp: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(stamp))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func initialDataLoad() {
        let appData = AppData(context: PersistenceController.shared.container.viewContext)
        appData.unit = "imperial"
        appData.mainIsCurrent = false
        
        PersistenceController.shared.saveContext()
    }
}
