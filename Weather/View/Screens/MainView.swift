//

import SwiftUI

struct MainView: View {
    @StateObject var tabSelection = TabSelection()
    
    var body: some View {
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
        .environmentObject(tabSelection)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
