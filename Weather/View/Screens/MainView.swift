//

import SwiftUI
import CoreLocation

struct MainView: View {
    // environment
    @StateObject var tabSelection = TabSelection()
    @StateObject var locationManager = LocationManager()
    @StateObject var cityViewModel = CityViewModel()
    
    @FetchRequest(sortDescriptors: [])
    var appData: FetchedResults<AppData>
    @FetchRequest(sortDescriptors: [])
    var cities: FetchedResults<City>
    
    var body: some View {
        // tab view
        TabView (selection: $tabSelection.tab) {
            HomeView()
                .tabItem {
                    Image(systemName: tabSelection.tab == "home" ? "house.fill" : "house")
                }
                .tag("home")
            MapView()
                .tabItem {
                    Image(systemName: "mappin")
                }
                .tag("map")
//            CitiesView()
            CitiesView()
                .tabItem {
                    Image(systemName: tabSelection.tab == "cities" ? "heart.fill" : "heart")
                }
                .tag("cities")
            SettingsView()
                .tabItem {
                    Image(systemName: tabSelection.tab == "settings" ? "gearshape.fill" : "gearshape")
                }
                .tag("settings")
        }
        .foregroundColor(.white)
        .font(.system(size: 17))
        .preferredColorScheme(.dark)
        .environmentObject(tabSelection)
        .environmentObject(locationManager)
        .environmentObject(cityViewModel)
        .onAppear {
            if appData.isEmpty {
                cityViewModel.initialDataLoad()
            }
            
            cityViewModel.unit = appData[0].unit ?? "imperial"
            
            if !cities.isEmpty {
                var addMain = true
                cityViewModel.savedCities = []
                for city in cities {
                    if city.type == "saved" {
                        cityViewModel.cityRequest(location: CLLocation(latitude: city.lat, longitude: city.lon), save: "saved", unit: cityViewModel.unit)
                    }
                    
                    if city.type == "main" {
                        addMain = false
                        cityViewModel.cityRequest(location: CLLocation(latitude: city.lat, longitude: city.lon), save: "main", unit: cityViewModel.unit)
                    }
                }
                if addMain {
                    let addMainCity = City(context: PersistenceController.shared.container.viewContext)
                    addMainCity.lat = locationManager.manager.location?.coordinate.latitude ?? 51.507222
                    addMainCity.lon = locationManager.manager.location?.coordinate.longitude ?? -0.1275
                    addMainCity.type = "main"
                    PersistenceController.shared.saveContext()
                }
            } else {
                // get main city data
                cityViewModel.cityRequest(location: locationManager.manager.location ?? CLLocation(latitude: 51.507222, longitude: -0.1275), save: "main", unit: cityViewModel.unit)
                let addMainCity = City(context: PersistenceController.shared.container.viewContext)
                addMainCity.lat = locationManager.manager.location?.coordinate.latitude ?? 51.507222
                addMainCity.lon = locationManager.manager.location?.coordinate.longitude ?? -0.1275
                addMainCity.type = "main"
                PersistenceController.shared.saveContext()
            }
            
            // get current city data
            if locationManager.locationStatus == .authorizedWhenInUse {
                cityViewModel.cityRequest(location: locationManager.manager.location ?? CLLocation(latitude: 51.507222, longitude: -0.1275), save: "current", unit: cityViewModel.unit)
            }
        }
    }
}

class TabSelection: ObservableObject {
    @Published var tab = "home"
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
