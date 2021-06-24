//

import Foundation
import SwiftUI

struct miscData {
    static let viewHeight = UIScreen.main.bounds.height - (UIScreen.main.bounds.height * 0.15)
    static let tempCityModel = CityData(lat: 0, lon: 0, current: Current(sunrise: 0, sunset: 0, temp: 0, pressure: 0, humidity: 0, uvi: 0, wind_speed: 0, weather: [Weather(id: 0, main: "_", description: "_")]), hourly: [Hourly(dt: 0, temp: 0, weather: [Weather(id: 0, main: "_", description: "_")], pop: 0)], daily: [Daily(dt: 0, temp: Temp(min: 0, max: 0), weather: [Weather(id: 0, main: "_", description: "_")], pop: 0)])
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
            if hidden {
                if !remove {
                    self.hidden()
                }
            } else {
                self
            }
        }
}
