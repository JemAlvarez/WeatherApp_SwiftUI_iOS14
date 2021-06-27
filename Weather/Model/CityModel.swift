//

import Foundation

struct CityModel: Identifiable {
    let id = UUID()
    var cityName: CityName
    var cityData: CityData
}

struct CityName {
    let city: String
    let state: String
    let country: String
}

struct CityData: Codable {
    let lat: Double
    let lon: Double
    var current: Current
    var hourly: [Hourly]
    var daily: [Daily]
}

struct Current: Codable {
    let sunrise: Int
    let sunset: Int
    var temp: Double
    let pressure: Double
    let humidity: Double
    let uvi: Double
    var wind_speed: Double
    let weather: [Weather]
}

struct Hourly: Codable {
    let dt: Int
    var temp: Double
    let weather: [Weather]
    let pop: Double
}

struct Daily: Codable {
    let dt: Int
    var temp: Temp
    let weather: [Weather]
    let pop: Double
}

struct Temp: Codable {
    var min: Double
    var max: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Minutely: Codable, Hashable {
    let precipitation: Double
}
