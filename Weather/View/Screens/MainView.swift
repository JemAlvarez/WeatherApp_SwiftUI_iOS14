//

import SwiftUI

struct MainView: View {
    // environment
    @StateObject var tabSelection = TabSelection()
    @StateObject var locationManager = LocationManager()
    
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
        .environmentObject(tabSelection)
        .environmentObject(locationManager)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
