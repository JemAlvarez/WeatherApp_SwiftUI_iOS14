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
                                withAnimation {
                                    region.span.latitudeDelta -= 0.2
                                    region.span.longitudeDelta -= 0.2
                                }
                            }
                            CustomMapUI {
                                Image(systemName: "minus")
                                    .frame(height: 20)
                            }
                            .onTapGesture {
                                withAnimation {
                                    region.span.latitudeDelta += 0.2
                                    region.span.longitudeDelta += 0.2
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
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
