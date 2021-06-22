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
            ScrollView (showsIndicators: false) {
                // main stack
                VStack (spacing: 30) {
                    // main top stack
                    HStack {
                        // temp info
                        VStack (alignment: .leading) {
                            Text("San Francisco")
                                .font(.system(size: 22))
                            
                            Text("\(cityViewModel.city.cityData.current.temp, specifier: "%.1f")º")
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
                        Image("few_clouds")
                            .resizable()
                            .scaledToFit()
                            .offset(x: imageOffset)
                    }
                    
                    // data info
                    VStack (spacing: 15) {
                        // top info
                        HStack {
                            SmallDataView(image: "wind", data: Text("\(4.4, specifier: "%.1f") mph"), font: .system(size: 16))
                            
                            Spacer()
                            
                            SmallDataView(image: "drop", data: Text("7%"), font: .system(size: 16))
                            
                            Spacer()
                            
                            SmallDataView(image: "exclamationmark.3", data: Text("\(0.533, specifier: "%.3f") mBar"), font: .system(size: 16))
                        }
                        
                        // bot info
                        HStack {
                            SmallDataView(image: "wind", data: Text("\(4.4, specifier: "%.1f") mph"), font: .system(size: 16))
                            
                            Spacer()
                            
                            SmallDataView(image: "drop", data: Text("7%"), font: .system(size: 16))
                            
                            Spacer()
                            
                            SmallDataView(image: "exclamationmark.3", data: Text("\(0.533, specifier: "%.3f") mBar"), font: .system(size: 16))
                        }
                    }
                    .padding()
                    .background(Color("backgroundLight").opacity(0.7))
                    .cornerRadius(20)
                    
                    // _____ RAIN GRAPH _____
                    
                    // today forecast
                    VStack (alignment: .leading) {
                        // title
                        Text("Today")
                            .opacity(0.5)
                        
                        // scroll horizontal
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack (spacing: 40) {
                                // loop
                                ForEach(0..<10) {i in
                                    // card
                                    TodayCardView(time: "10 AM", image: "clear_sky", temp: "19º")
                                }
                            }
                        }
                    }
                    
                    // daily forecast
                    VStack {
                        DailyRowView(day: "Today", image: "clear_sky", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Tuesday", image: "few_clouds", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Wednesday", image: "mist", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Thursday", image: "rain", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Friday", image: "scattered_clouds", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Saturday", image: "shower_rain", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Sunday", image: "snow", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Monday", image: "thunderstorm", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Tuesday", image: "clear_sky", tempLow: "15", tempHigh: "19")
                        DailyRowView(day: "Wednesday", image: "rain", tempLow: "15", tempHigh: "19")
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 30)
            }
            .padding(.bottom)
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
