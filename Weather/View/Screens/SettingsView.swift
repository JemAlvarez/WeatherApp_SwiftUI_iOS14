//


import SwiftUI
import MapKit

struct SettingsView: View {
    // states
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var tabSelection: TabSelection
    @State var imageZoom: CGFloat = 1
    @State var headerOffset: CGFloat = -100
    @State var locationStatus = "Allowed"
    
    var body: some View {
        // view
        CustomScreenView(customScreen: {
            VStack {
                if locationStatus == "Allowed" {
                    // top info
                    VStack {
                        HStack {
                            Image(systemName: "target")
                            Text("Your Location Now")
                        }
                        .font(.subheadline)
                        .opacity(0.4)
                        .padding(.bottom, 5)
                        .padding(.top, 30)
                        
                        Text("San Fransisco, California, USA")
                            .font(.title2)
                    }
                    .offset(y: headerOffset)
                    
                    // weather image
                    ZStack {
                        Color("backgroundLight")
                            .clipShape(Circle())
                            .blur(radius: 25)
                        Image("moonSun")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 1.8)
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.6, height: UIScreen.main.bounds.width / 1.6)
                    .scaleEffect(imageZoom)
                    
                    // caption
                    Text("Moonlight")
                        .padding(.horizontal, 15)
                        .padding(.vertical, 7)
                        .background(Color("purple"))
                        .clipShape(Capsule())
                        .font(.headline)
                    
                    // temperature
                    HStack (spacing: 0) {
                        Text("20")
                        Text("º")
                            .offset(y: -15)
                        Text("C")
                    }
                    .font(.system(size: 55).bold())
                    .padding(.vertical)
                    
                    // data info
                    VStack (spacing: 15) {
                        // top info
                        HStack (spacing: 30) {
                            SmallDataView(image: "wind", data: Text("\(4.4, specifier: "%.1f") mph"), font: .body)
                            
                            SmallDataView(image: "drop", data: Text("7%"), font: .body)
                            
                            SmallDataView(image: "exclamationmark.3", data: Text("\(0.533, specifier: "%.3f") mBar"), font: .body)
                        }
                        
                        // bot info
                        HStack (spacing: 30) {
                            SmallDataView(image: "wind", data: Text("\(4.4, specifier: "%.1f") mph"), font: .body)
                            
                            SmallDataView(image: "drop", data: Text("7%"), font: .body)
                            
                            SmallDataView(image: "exclamationmark.3", data: Text("\(0.533, specifier: "%.3f") mBar"), font: .body)
                        }
                    }
                } else {
                    Text("Allow location privacy settings to see your current location inforamtion.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(50)
                        .opacity(0.4)
                }
                
                // settings
                VStack (spacing: 20) {
                    // temp f/c
                    HStack {
                        Text("Temperature")
                        
                        Spacer()
                        
                        Menu {
                            Button(action: {
                                
                            }) {
                                Text("Farenheit")
                            }
                            
                            Button(action: {
                                
                            }) {
                                Text("Celcius")
                            }
                        }
                        label: {
                            HStack {
                                Text("Celcius")
                                    .opacity(0.4)
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                    // wind
                    HStack {
                        Text("Wind Speed")
                        
                        Spacer()
                        
                        Menu {
                            Button(action: {
                                
                            }) {
                                Text("m/s")
                            }
                            
                            Button(action: {
                                
                            }) {
                                Text("mph")
                            }
                        }
                        label: {
                            HStack {
                                Text("mph")
                                    .opacity(0.4)
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                    // location
                    HStack {
                        Text("Location Privacy")
                        
                        Spacer()
                        
                        Button(action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }) {
                            HStack {
                                Text(locationStatus)
                                    .opacity(0.4)
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 35)
                .padding(.top, 30)
                
                Spacer()
                
                // weather info source
                HStack (spacing: 30) {
                    Text("Source")
                                                
                    HStack {
                        Text("weather.gov")
                        Image(systemName: "info.circle")
                    }
                }
                .opacity(0.4)
                .padding(.bottom, 30)
            }
        }, background: {
            // background gradient
            LinearGradient(gradient: Gradient(colors: [Color("background").opacity(0.94), Color("background"), Color("background").opacity(0.94)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        })
        // tab change animation
        .onChange(of: tabSelection.tab) {newValue in
            if newValue == "settings" {
                withAnimation {
                    imageZoom = 1
                    headerOffset = 0
                }
            } else {
                headerOffset = -100
                imageZoom = 0.8
            }
        }
        // location status change
        .onChange(of: locationManager.locationStatus) { newValue in
            if newValue == .authorizedWhenInUse {
                locationStatus = "Allowed"
            } else {
                locationStatus = "Not Allowed"
            }
        }
        .onAppear {
            locationStatus = locationManager.manager.authorizationStatus == .authorizedWhenInUse ? "Allowed" : "Not Allowed"
            
            if tabSelection.tab == "settings" {
                withAnimation {
                    headerOffset = 0
                    imageZoom = 1
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
