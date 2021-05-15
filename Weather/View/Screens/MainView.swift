//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            MapView()
                .tabItem {
                    Image(systemName: "mappin")
                }
            CitiesView()
                .tabItem {
                    Image(systemName: "heart")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                }
        }
        .foregroundColor(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
