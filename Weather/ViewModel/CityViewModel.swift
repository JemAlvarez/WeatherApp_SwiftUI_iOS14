//

import Foundation
import CoreLocation
import CoreData

class CityViewModel: ObservableObject {
    @Published var mainCity = CityModel(cityName: "", cityData: miscData.tempCityModel)
    @Published var currentLocationCity = CityModel(cityName: "", cityData: miscData.tempCityModel)
    @Published var mapCity = CityModel(cityName: "", cityData: miscData.tempCityModel)
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
    
    func initialDataLoad() {
        let appData = AppData(context: PersistenceController.shared.container.viewContext)
        appData.unit = "imperial"
        appData.mainIsCurrent = false
        
        PersistenceController.shared.saveContext()
    }
}
