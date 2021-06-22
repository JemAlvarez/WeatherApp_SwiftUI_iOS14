//

import Foundation

class CityViewModel: ObservableObject {
    @Published var city: CityModel = CityModel(cityData: miscData.tempCityModel)
    @Published var unit = "imperial" {
        didSet {
            cityRequest(lat: "33.44", lon: "-94.04")
        }
    }
    
    var lat: Double = 0
    var lon: Double = 0
    
    func cityRequest(lat: String, lon: String) {
        ApiModel().getCity(lat: lat, lon: lon, unit: unit) { city in
            self.city = city
        }
    }
}
