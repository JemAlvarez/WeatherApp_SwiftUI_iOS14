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
    }
}

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let standardAppearance = UITabBarAppearance()
        
        standardAppearance.configureWithTransparentBackground()

        tabBar.standardAppearance = standardAppearance
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
