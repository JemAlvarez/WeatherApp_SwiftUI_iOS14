//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        CustomScreenView (customScreen: {
            ZStack(alignment: .bottomTrailing) {
                Map(
                    coordinateRegion: $region,
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true
                )
                    .cornerRadius(20)
                    .edgesIgnoringSafeArea(.top)
                
                HStack {
                    Image(systemName: "cloud.rain.fill")
                    Text("72º")
                        .opacity(0.5)
                }
                .padding(10)
                .background(Color("backgroundLight"))
                .cornerRadius(10)
                .padding(30)
            }
        }) {
            Color("background").edgesIgnoringSafeArea(.all)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
