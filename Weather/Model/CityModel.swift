//

import Foundation

struct CityModel: Identifiable {
    let id = UUID()
    let cityData: CityData
}

struct CityData: Codable {
    let lat: Double
    let lon: Double
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let pressure: Double
    let humidity: Double
    let uvi: Double
    let wind_speed: Double
    let weather: [Weather]
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
    let pop: Double
}

struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
    let pop: Double
}

struct Temp: Codable {
    let min: Double
    let max: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}
