//


import SwiftUI
import MapKit

struct SettingsView: View {
    // states
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var tabSelection: TabSelection
    @EnvironmentObject var cityViewModel: CityViewModel
    @State var imageZoom: CGFloat = 1
    @State var headerOffset: CGFloat = 0
    @State var locationStatus = "Allowed"
    @State var animationOpacity: Double = 0
    @State var citySet = false
    
    var body: some View {
        // view
        CustomScreenView(customScreen: {
            ZStack {
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
                            .font(.system(size: 17))
                            .opacity(0.4)
                            .padding(.bottom, 2)
                            .padding(.top, 10)
                            
                            Text("San Fransisco, California, USA")
                                .font(.system(size: 21))
                                .offset(y: headerOffset)
                        }
                        
                        Spacer()
                        
                        // weather image
                        ZStack {
                            Color("backgroundLight")
                                .clipShape(Circle())
                                .blur(radius: 25)
                            Image(cityViewModel.getWeatherImage(id: cityViewModel.currentLocationData.cityData.current.weather[0].id))
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 2)
                        }
                        .frame(width: UIScreen.main.bounds.width / 1.8, height: UIScreen.main.bounds.width / 1.8)
                        .scaleEffect(imageZoom)
                        
                        // caption
                        Text(cityViewModel.currentLocationData.cityData.current.weather[0].main)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 7)
                            .background(Color("purple").opacity(0.5))
                            .clipShape(Capsule())
                            .font(.system(size: 17).bold())
                        
                        Spacer()
                        
                        // temperature
                        HStack (spacing: 0) {
                            Text("\(cityViewModel.currentLocationData.cityData.current.temp, specifier: "%.1f")º")
                            Text(cityViewModel.unit == "imperial" ? "F" : "C")
                        }
                        .font(.system(size: 40).bold())
                        .padding(.vertical)
                        
                        Spacer()
                        
                        // data info
                        VStack (alignment: .leading, spacing: 15) {
                            // top info
                            HStack (spacing: 10) {
                                SmallDataView(image: "sunrise.fill", data: Text(cityViewModel.getTime(stamp: cityViewModel.currentLocationData.cityData.current.sunrise)), font: .system(size: 15))
                                    .frame(width: 100)
                                                                
                                SmallDataView(image: "drop", data: Text("\(Int(cityViewModel.currentLocationData.cityData.daily[0].pop))%"), font: .system(size: 15))
                                    .frame(width: 80)
                                                                
                                SmallDataView(image: "wind", data: Text("\(cityViewModel.currentLocationData.cityData.current.wind_speed, specifier: "%.1f") \(cityViewModel.unit == "imperial" ? "mph" : "m/s")"), font: .system(size: 15))
                            }
                            
                            // bot info
                            HStack (spacing: 10) {
                                SmallDataView(image: "sunset.fill", data: Text(cityViewModel.getTime(stamp: cityViewModel.currentLocationData.cityData.current.sunset)), font: .system(size: 15))
                                    .frame(width: 100)
                                                                
                                SmallDataView(image: "drop.triangle", data: Text("\(Int(cityViewModel.currentLocationData.cityData.current.humidity))%"), font: .system(size: 15))
                                    .frame(width: 80)
                                                                
                                SmallDataView(image: "speedometer", data: Text("\(Int(cityViewModel.currentLocationData.cityData.current.pressure)) mbar"), font: .system(size: 15))
                            }
                        }
                    } else {
                        Text("Allow location privacy settings to see your current location inforamtion.")
                            .font(.system(size: 20))
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
                                cityViewModel.unit = "metric"
                                changeOnUnit()
                            }) {
                                Text("Metric")
                            }
                            
                            Button(action: {
                                cityViewModel.unit = "imperial"
                                changeOnUnit()
                            }) {
                                Text("Imperial")
                            }
                        }
                        label: {
                            VStack (spacing: 5) {
                                HStack {
                                    Image(systemName: "thermometer")
                                    Text("/")
                                    Image(systemName: "wind")
                                }
                                Text(cityViewModel.unit.capitalized)
                                    .opacity(0.4)
                                    .frame(width: 80)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            cityViewModel.city = cityViewModel.currentLocationData
                            
                            withAnimation {
                                citySet = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                citySet = false
                            }
                        }) {
                            VStack (spacing: 5) {
                                Image(systemName: "pin.fill")
                                Text("Set as main")
                                    .opacity(0.4)
                            }
                        }
                        
                        Spacer()
                        
                        // location
                        Button(action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }) {
                            VStack (spacing: 8) {
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
                
                if citySet {
                    Text("City set as main city!")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(15)
                }
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
    
    func changeOnUnit() {
        cityViewModel.cityRequest(lat: "33.44", lon: "-94.04", save: "main")
        
        if locationManager.locationStatus == .authorizedWhenInUse {
            cityViewModel.cityRequest(lat: "\(locationManager.manager.location!.coordinate.latitude)", lon: "\(locationManager.manager.location!.coordinate.longitude)", save: "current")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(LocationManager()).environmentObject(TabSelection()).environmentObject(CityViewModel())
    }
}
