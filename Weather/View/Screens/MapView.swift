//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @State var citySet = false
    @State var cityFav = false
    @State var userLocation = false
    @State var location = "London"
    
    var body: some View {
        CustomScreenView (customScreen: {
            ZStack {
                Map(
                    coordinateRegion: $region,
                    interactionModes: MapInteractionModes.all
//                    showsUserLocation: true
                )
                    .cornerRadius(20)
                    .edgesIgnoringSafeArea(.top)
                
                VStack {
                    HStack (alignment: .top) {
                        CustomMapUI {
                            Text(location)
                                .font(.title)
                                .padding(.horizontal)
                        }
                        .padding([.horizontal,.top], 30)
                        
                        Spacer()
                        
                        VStack (spacing: 5) {
                            CustomMapUI {
                                Image(systemName: citySet ? "mappin.circle.fill" : "mappin.circle")
                                    .frame(width: 20)
                                    .foregroundColor(citySet ? .green : .primary)
                            }
                            .padding(.top, 30)
                            .onTapGesture {
                                withAnimation {
                                    citySet.toggle()
                                }
                            }
                            
                            CustomMapUI {
                                Image(systemName: cityFav ? "star.fill" : "star")
                                    .frame(width: 20)
                                    .foregroundColor(cityFav ? .yellow : .primary)
                            }
                            .onTapGesture {
                                withAnimation {
                                    cityFav.toggle()
                                }
                            }
                            
                            CustomMapUI {
                                Image(systemName: userLocation ? "location.fill" : "location")
                                    .frame(width: 20)
                                    .foregroundColor(userLocation ? .blue : .primary)
                            }
                            .onTapGesture {
                                withAnimation {
                                    userLocation.toggle()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    HStack {
                        VStack (spacing: 0) {
                            CustomMapUI {
                                Image(systemName: "plus")
                                    .frame(height: 20)
                            }
                            .onTapGesture {
                                let zoomIncrement = calculateZoom("plus")
                                let lat = region.span.latitudeDelta
                                let lon = region.span.longitudeDelta
                                
                                print("latitude", lat)
                                print("new latitude", lat - zoomIncrement)
                                
                                if (lat - zoomIncrement) > 0 && (lon - zoomIncrement) > 0 {
                                    withAnimation {
                                        region.span.latitudeDelta -= zoomIncrement
                                        region.span.longitudeDelta -= zoomIncrement
                                    }
                                } else {
                                    withAnimation {
                                        region.span.latitudeDelta = 0
                                        region.span.longitudeDelta = 0
                                    }
                                }
                            }
                            CustomMapUI {
                                Image(systemName: "minus")
                                    .frame(height: 20)
                            }
                            .onTapGesture {
                                let zoomIncrement = calculateZoom("minus")
                                let lat = region.span.latitudeDelta
                                let lon = region.span.longitudeDelta
                                
                                if (lat + zoomIncrement) < 100 && (lon + zoomIncrement) < 100 {
                                    withAnimation {
                                        region.span.latitudeDelta += zoomIncrement
                                        region.span.longitudeDelta += zoomIncrement
                                    }
                                } else {
                                    withAnimation {
                                        region.span.latitudeDelta = 100
                                        region.span.longitudeDelta = 100
                                    }
                                }
                            }
                        }
                        .padding([.horizontal, .bottom], 30)
                        
                        Spacer()
                        
                        CustomMapUI {
                            HStack {
                                Image(systemName: "cloud.rain.fill")
                                Text("72º")
                                    .opacity(0.5)
                            }
                        }
                        .padding(30)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }) {
            Color("background").edgesIgnoringSafeArea(.all)
        }
    }
    
    func calculateZoom(_ zoomType: String) -> CLLocationDegrees {
        let lat = region.span.latitudeDelta
        var zoomIncrement: CLLocationDegrees = 0
        
        if lat == 0 {
            zoomIncrement = 0.05
        } else if zoomType == "plus" {
            zoomIncrement = lat / 2
        } else if zoomType == "minus" {
            zoomIncrement = lat * 2
        }
        
        return zoomIncrement
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
