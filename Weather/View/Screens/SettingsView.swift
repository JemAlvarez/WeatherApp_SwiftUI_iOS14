//


import SwiftUI
import MapKit

struct SettingsView: View {
    // states
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var tabSelection: TabSelection
    @State var imageZoom: CGFloat = 1
    @State var headerOffset: CGFloat = 0
    @State var locationStatus = "Allowed"
    @State var tempDegree = "F"
    @State var windSpeedUnit = "mph"
    @State var animationOpacity: Double = 0
    
    var body: some View {
        // view
        CustomScreenView(customScreen: {
            VStack (spacing: 0) {
                if locationStatus == "Allowed" {
                    // top info header
                    VStack {
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.accentColor)
                                    .opacity(animationOpacity)
                                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true))
                                
                                Image(systemName: "target")
                            }
                            .onAppear{
                                withAnimation {
                                    animationOpacity = 0.7
                                }
                            }
                            
                            Text("Your Location Now")
                        }
                        .font(.subheadline)
                        .opacity(0.4)
                        .padding(.bottom, 2)
                        .padding(.top, 10)
                        
                        Text("San Fransisco, California, USA")
                            .font(.title2)
                            .offset(y: headerOffset)
                    }
                    
                    Spacer()
                    
                    // weather image
                    ZStack {
                        Color("backgroundLight")
                            .clipShape(Circle())
                            .blur(radius: 25)
                        Image("shower_rain")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 2)
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.8, height: UIScreen.main.bounds.width / 1.8)
                    .scaleEffect(imageZoom)
                    
                    // caption
                    Text("Moonlight")
                        .padding(.horizontal, 15)
                        .padding(.vertical, 7)
                        .background(Color("purple").opacity(0.5))
                        .clipShape(Capsule())
                        .font(.headline)
                    
                    Spacer()
                    
                    // temperature
                    HStack (spacing: 0) {
                        Text("20")
                        Text("º")
                            .offset(y: -15)
                        Text("C")
                    }
                    .font(.system(size: 40).bold())
                    .padding(.vertical)
                    
                    Spacer()
                    
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
                
                Spacer()
                
                // settings
                HStack {
                    // temp f/c
                    Menu {
                        Button(action: {
                            tempDegree = "F"
                        }) {
                            Text("Farenheit")
                        }
                        
                        Button(action: {
                            tempDegree = "C"
                        }) {
                            Text("Celcius")
                        }
                    }
                    label: {
                        VStack (spacing: 5) {
                            Image(systemName: "thermometer")
                            Text(tempDegree)
                                .opacity(0.4)
                        }
                    }
                    
                    Spacer()
                    
                    // wind
                    Menu {
                        Button(action: {
                            windSpeedUnit = "m/s"
                        }) {
                            Text("m/s")
                        }
                        
                        Button(action: {
                            windSpeedUnit = "mph"
                        }) {
                            Text("mph")
                        }
                    }
                    label: {
                        VStack (spacing: 5) {
                            Image(systemName: "wind")
                            Text(windSpeedUnit)
                                .opacity(0.4)
                        }
                    }
                    
                    Spacer()
                    
                    // location
                    Button(action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }) {
                        VStack (spacing: 5) {
                            Image(systemName: locationStatus == "Allowed" ? "location.fill" : "location.slash.fill")
                            Text(locationStatus)
                                .opacity(0.4)
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 70)
                .padding(.top, 20)
                
                // weather info source
                HStack (spacing: 30) {
                    Text("Source")
                                                
                    HStack {
                        Text("weather.gov")
                        Image(systemName: "info.circle")
                    }
                }
                .opacity(0.4)
                .padding(.top, 20)
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
        SettingsView().environmentObject(LocationManager()).environmentObject(TabSelection())
    }
}
