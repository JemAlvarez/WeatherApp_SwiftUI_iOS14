//

import SwiftUI
import CoreLocation

struct MainView: View {
    // environment
    @StateObject var tabSelection = TabSelection()
    @StateObject var locationManager = LocationManager()
    @StateObject var cityViewModel = CityViewModel()
    
    var body: some View {
        // tab view
        TabView (selection: $tabSelection.tab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
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
                    Image(systemName: "heart")
                }
                .tag("cities")
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
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
            // get main city data
            cityViewModel.cityRequest(lat: "33.44", lon: "-94.04", save: "main")
            
            // set current location coords
            locationManager.coords = locationManager.manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
            
            // get current city data
            if locationManager.locationStatus == .authorizedWhenInUse {
                cityViewModel.cityRequest(lat: "\(locationManager.coords.latitude)", lon: "\(locationManager.coords.longitude)", save: "current")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
