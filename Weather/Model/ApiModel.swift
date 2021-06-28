//

import Foundation
import CoreLocation

class ApiModel {
    func getCity(location: CLLocation, unit: String?, completion: @escaping (CityModel) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/\(Constants.weatherApiVersion)/onecall?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&exclude=minutely,alerts&appid=\(Constants.weatherApiKey)&units=\(unit ?? "imperial")")
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
    
    func getMinutely(location: CLLocation, completion: @escaping ([Minutely]) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/\(Constants.weatherApiVersion)/onecall?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&exclude=current,hourly,daily,alerts&appid=\(Constants.weatherApiKey)&units=imperial") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let minutely = try! JSONDecoder().decode(CityMinutely.self, from: data!)
            
            print(minutely.minutely)
            
            DispatchQueue.main.async {
                completion(minutely.minutely)
            }
        }
        .resume()
    }
}
