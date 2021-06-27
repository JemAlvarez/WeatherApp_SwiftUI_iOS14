//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tabSelection: TabSelection
    @EnvironmentObject var cityViewModel: CityViewModel
    @State var mainInfoOffset: CGFloat = -100
    @State var imageOffset: CGFloat = 100
    
    var body: some View {
        // view
        CustomScreenView(customScreen: {
            // scroll view
            if cityViewModel.loadingMain {
                ProgressView()
            } else {
                ScrollView (showsIndicators: false) {
                    // main stack
                    VStack (spacing: 30) {
                        // main top stack
                        HStack {
                            // temp info
                            VStack (alignment: .leading) {
                                HStack {
                                    Text(cityViewModel.mainCity.cityName.city)
                                        .font(.system(size: 22))
                                    
                                    if cityViewModel.mainCity.cityName.city == cityViewModel.currentLocationCity.cityName.city {
                                        Image(systemName: "location.fill")
                                    }
                                }
                                
                                Text("\(Int(cityViewModel.mainCity.cityData.current.temp))º")
                                    .font(.system(size: 70).bold())
                                
                                Text("Cloudy")
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 7)
                                    .background(Color("purple").opacity(0.5))
                                    .clipShape(Capsule())
                                    .font(.system(size: 17).bold())
                            }
                            .offset(x: mainInfoOffset)
                            
                            Spacer()
                            
                            // image
                            Image(cityViewModel.getWeatherImage(id: cityViewModel.mainCity.cityData.current.weather[0].id))
                                .resizable()
                                .scaledToFit()
                                .offset(x: imageOffset)
                                .frame(height: 170)
                        }
                        
                        // data info
                        VStack (alignment: .leading, spacing: 15) {
                            // top info
                            HStack (spacing: 10) {
                                SmallDataView(image: "sunrise.fill", data: Text(cityViewModel.getTime(stamp: cityViewModel.currentLocationCity.cityData.current.sunrise, format: "h:mm a")), font: .system(size: 15))
                                    .frame(width: 100)
                                                                
                                SmallDataView(image: "drop", data: Text("\(Int(cityViewModel.currentLocationCity.cityData.daily[0].pop * 100))%"), font: .system(size: 15))
                                    .frame(width: 80)
                                                                
                                SmallDataView(image: "wind", data: Text("\(cityViewModel.currentLocationCity.cityData.current.wind_speed, specifier: "%.1f") \(cityViewModel.unit == "imperial" ? "mph" : "m/s")"), font: .system(size: 15))
                            }
                            
                            // bot info
                            HStack (spacing: 10) {
                                SmallDataView(image: "sunset.fill", data: Text(cityViewModel.getTime(stamp: cityViewModel.currentLocationCity.cityData.current.sunset, format: "h:mm a")), font: .system(size: 15))
                                    .frame(width: 100)
                                                                
                                SmallDataView(image: "drop.triangle", data: Text("\(Int(cityViewModel.currentLocationCity.cityData.current.humidity))%"), font: .system(size: 15))
                                    .frame(width: 80)
                                                                
                                SmallDataView(image: "speedometer", data: Text("\(Int(cityViewModel.currentLocationCity.cityData.current.pressure)) hpa"), font: .system(size: 15))
                            }
                        }
                        .padding()
                        .background(Color("backgroundLight").opacity(0.7))
                        .cornerRadius(20)
                        
                        // _____ RAIN GRAPH _____
                        
                        // today forecast
                        VStack (alignment: .leading) {
                            // title
                            HStack {
                                Image(systemName: "clock")
                                Text("Today")
                            }
                                .opacity(0.5)
                            
                            // scroll horizontal
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack (spacing: 20) {
                                    // loop
                                    ForEach(0..<cityViewModel.mainCity.cityData.hourly.count / 2, id: \.self) {i in
                                        // card
                                        TodayCardView(time: i == 0 ? "Now" : cityViewModel.getTime(stamp: cityViewModel.mainCity.cityData.hourly[i].dt, format: "h a"), image: cityViewModel.getWeatherImage(id: cityViewModel.mainCity.cityData.hourly[i].weather[0].id), temp: "\(Int(cityViewModel.mainCity.cityData.hourly[i].temp))º", pop: cityViewModel.mainCity.cityData.hourly[i].weather[0].main == "Rain" || cityViewModel.mainCity.cityData.hourly[i].weather[0].main == "Drizzle" || cityViewModel.mainCity.cityData.hourly[i].weather[0].main == "Thunderstorm" ? Int(cityViewModel.mainCity.cityData.hourly[i].pop * 100) : nil)
                                    }
                                }
                            }
                        }
                        
                        // daily forecast
                        VStack (alignment: .leading) {
                            HStack {
                                Image(systemName: "calendar")
                                Text("8-Day Forecast")
                            }
                            .opacity(0.5)
                            
                            ForEach(0..<cityViewModel.mainCity.cityData.daily.count, id: \.self) { i in
                                DailyRowView(day: i == 0 ? "Today" : cityViewModel.getTime(stamp: cityViewModel.mainCity.cityData.daily[i].dt, format: "EEEE"), image: cityViewModel.getWeatherImage(id: cityViewModel.mainCity.cityData.daily[i].weather[0].id), tempLow: "\(Int(cityViewModel.mainCity.cityData.daily[i].temp.min))", tempHigh: "\(Int(cityViewModel.mainCity.cityData.daily[i].temp.max))", pop: cityViewModel.mainCity.cityData.daily[i].weather[0].main == "Rain" || cityViewModel.mainCity.cityData.daily[i].weather[0].main == "Drizzle" || cityViewModel.mainCity.cityData.daily[i].weather[0].main == "Thunderstorm" ? Int(cityViewModel.mainCity.cityData.daily[i].pop * 100) : nil)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                }
                .padding(.bottom)
            }
        }, background: {
            // view background
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        })
        .onChange(of: tabSelection.tab) { newValue in
            if newValue == "home" {
                withAnimation {
                    mainInfoOffset = 0
                    imageOffset = 0
                }
            } else {
                mainInfoOffset = -100
                imageOffset = 100
            }
        }
        .onAppear {
            if tabSelection.tab == "home" {
                withAnimation {
                    mainInfoOffset = 0
                    imageOffset = 0
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(TabSelection())
    }
}
