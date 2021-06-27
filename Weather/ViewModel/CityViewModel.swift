//

import Foundation
import CoreLocation
import CoreData
import SwiftUI

class CityViewModel: ObservableObject {
    @Published var mainCity = miscData.tempCityModel
    @Published var currentLocationCity = miscData.tempCityModel
    @Published var mapCity = miscData.tempCityModel
    @Published var searchCity = miscData.tempCityModel
    @Published var savedCities: [CityModel] = []
    @Published var unit = "imperial" {
        didSet {
            changeUnit()
        }
    }
    @Published var loadingMain = true
    @Published var loadingSearch = true
    
    func cityRequest(location: CLLocation, save: String, unit: String?) {
        ApiModel().getCity(location: location, unit: unit) { city in
            if save == "main" {
                self.mainCity = city
                
                withAnimation {
                    self.loadingMain = false
                }
            } else if save == "current" {
                self.currentLocationCity = city
            } else if save == "map" {
                self.mapCity = city
            } else if save == "search" {
                self.searchCity = city
                
                withAnimation {
                    self.loadingSearch = false
                }
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
    
    func changeUnit () {
        // main city
            // temp
                // current
        self.mainCity.cityData.current.temp = changeTemp(self.mainCity.cityData.current.temp)
                // today
        for i in 0..<self.mainCity.cityData.hourly.count {
            self.mainCity.cityData.hourly[i].temp = changeTemp(self.mainCity.cityData.hourly[i].temp)
        }
                // daily
        for i in 0..<self.mainCity.cityData.daily.count {
            self.mainCity.cityData.daily[i].temp.min = changeTemp(self.mainCity.cityData.daily[i].temp.min)
            self.mainCity.cityData.daily[i].temp.max = changeTemp(self.mainCity.cityData.daily[i].temp.max)
        }
            // wind
        // map city
            // temp
        self.mapCity.cityData.current.temp = changeTemp(self.mapCity.cityData.current.temp)
        // saved cities
            // temp
        for i in 0..<self.savedCities.count {
            self.savedCities[i].cityData.current.temp = changeTemp(self.savedCities[i].cityData.current.temp)
        }
            // wind
        // current city
            // temp
        self.currentLocationCity.cityData.current.temp = changeTemp(self.currentLocationCity.cityData.current.temp)
            // wind
    }
    
    func changeTemp(_ temp: Double) -> Double {
        var newTemp: Double = 0
        
        if self.unit == "imperial" {
            newTemp = (temp * 9/5) + 32
        } else if self.unit == "metric" {
            newTemp = (temp - 32) * 5/9
        }
        
        return newTemp
    }
}
