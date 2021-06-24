//

import Foundation
import CoreLocation

class ApiModel {
    func getCity(location: CLLocation, unit: String, completion: @escaping (CityModel) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/\(Constants.weatherApiVersion)/onecall?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&exclude=minutely,alerts&appid=\(Constants.weatherApiKey)&units=\(unit)")
        else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let city = try! JSONDecoder().decode(CityData.self, from: data!)
            
            DispatchQueue.main.async {
                LocationManager().getLocationName(location: location) { cityName in
                    completion(CityModel(cityName: cityName,cityData: city))
                }
            }
        }
        .resume()
    }
}
