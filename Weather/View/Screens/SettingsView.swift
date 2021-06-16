//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var tabSelection: TabSelection
    @State var imageZoom: CGFloat = 1
    @State var headerOffset: CGFloat = -100
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("background").opacity(0.94), Color("background"), Color("background").opacity(0.94)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                VStack {
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
                    
                    Text("Moonlight")
                        .padding(.horizontal, 15)
                        .padding(.vertical, 7)
                        .background(Color("purple"))
                        .clipShape(Capsule())
                        .font(.headline)
                    
                    HStack (spacing: 0) {
                        Text("20")
                        Text("º")
                            .offset(y: -15)
                        Text("C")
                    }
                    .font(.system(size: 55).bold())
                    .padding(.vertical)
                    
                    VStack (spacing: 15) {
                        HStack (spacing: 30) {
                            SmallDataView(image: "wind", data: Text("\(4.4, specifier: "%.1f") mph"), font: .body)
                            
                            SmallDataView(image: "drop", data: Text("7%"), font: .body)
                            
                            SmallDataView(image: "exclamationmark.3", data: Text("\(0.533, specifier: "%.3f") mBar"), font: .body)
                        }
                        
                        HStack (spacing: 30) {
                            SmallDataView(image: "wind", data: Text("\(4.4, specifier: "%.1f") mph"), font: .body)
                            
                            SmallDataView(image: "drop", data: Text("7%"), font: .body)
                            
                            SmallDataView(image: "exclamationmark.3", data: Text("\(0.533, specifier: "%.3f") mBar"), font: .body)
                        }
                    }
                    
                    VStack (spacing: 20) {
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
                        HStack {
                            Text("Location Privacy")
                            
                            Spacer()
                            
                            Menu {
                                Button(action: {
                                    
                                }) {
                                    Text("Don't Allow")
                                }
                                
                                Button(action: {
                                    
                                }) {
                                    Text("Allow")
                                }
                            }
                            label: {
                                HStack {
                                    Text("Allow")
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
                .frame(height: miscData.viewHeight)
                Spacer()
            }
        }
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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
