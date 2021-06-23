//

import Foundation

class ApiModel {
    func getCity(lat: String, lon: String, unit: String, completion: @escaping (CityModel) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/\(Constants.weatherApiVersion)/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=\(Constants.weatherApiKey)&units=\(unit)")
        else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            print("data", data!)
            let city = try! JSONDecoder().decode(CityData.self, from: data!)
            
            DispatchQueue.main.async {
                completion(CityModel(cityData: city))
            }
        }
        .resume()
    }
}
