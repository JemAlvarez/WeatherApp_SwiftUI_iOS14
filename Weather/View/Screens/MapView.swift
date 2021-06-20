//

import SwiftUI
import MapKit

struct MapView: View {
    // map and location
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @EnvironmentObject var locationManager: LocationManager
    
    // states
    @State var citySet = false
    @State var cityFav = false
    @State var tracking: MapUserTrackingMode = .follow
    @State var location = "London"
    @EnvironmentObject var tabSelection: TabSelection
    
    // body
    var body: some View {
        // view
        CustomScreenView (customScreen: {
            ZStack {
                // map
                Map(
                    coordinateRegion: $region,
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking
                )
                    .cornerRadius(20)
                    .edgesIgnoringSafeArea(.top)
                
                // buttons
                VStack {
                    // top buttons
                    HStack (alignment: .top) {
                        // left title
                        CustomMapUI {
                            Text(location)
                                .font(.title)
                                .padding(.horizontal)
                        }
                        .padding([.horizontal,.top], 30)
                        
                        Spacer()
                        
                        // right stack
                        VStack (spacing: 5) {
                            // set current location
                            CustomMapUI {
                                Image(systemName: citySet ? "mappin.circle.fill" : "mappin.circle")
                                    .frame(width: 20)
                                    .foregroundColor(citySet ? .green : .white)
                            }
                            .padding(.top, 30)
                            .onTapGesture {
                                withAnimation {
                                    citySet.toggle()
                                }
                            }
                            
                            // set favorite
                            CustomMapUI {
                                Image(systemName: cityFav ? "star.fill" : "star")
                                    .frame(width: 20)
                                    .foregroundColor(cityFav ? .yellow : .white)
                            }
                            .onTapGesture {
                                withAnimation {
                                    cityFav.toggle()
                                }
                            }
                            
                            // set tracking
                            CustomMapUI {
                                Image(systemName: tracking == .follow ? "location.fill" : "location")
                                    .frame(width: 20)
                                    .foregroundColor(tracking == .follow ? .blue : .white)
                            }
                            .onTapGesture {
                                withAnimation {
                                    if locationManager.locationStatus == .authorizedWhenInUse {
                                        if tracking == .follow {
                                            tracking = .none
                                        } else {
                                            tracking = .follow
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    // bottom buttons
                    HStack {
                        // left zoom buttons
                        VStack (spacing: 0) {
                            // zoom in
                            CustomMapUI {
                                Image(systemName: "plus")
                                    .frame(height: 20)
                            }
                            .onTapGesture {
                                tracking = .none
                                let zoomIncrement = calculateZoom("plus")
                                let lat = region.span.latitudeDelta
                                let lon = region.span.longitudeDelta
                                
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
                            // zoom out
                            CustomMapUI {
                                Image(systemName: "minus")
                                    .frame(height: 20)
                            }
                            .onTapGesture {
                                tracking = .none
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
                        
                        // right forecast
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
            // view background
            Color("background").edgesIgnoringSafeArea(.all)
        }
        // appear
        .onAppear {
            region.center = locationManager.manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
            
            if tabSelection.tab == "map" {
                region.span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            }
        }
        // tab change
        .onChange(of: tabSelection.tab) { newValue in
            if newValue != "map" {
                tracking = .follow
                region.span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            }
        }
    }
    
    // get zoom increment
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
