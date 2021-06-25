//

import SwiftUI

struct CitiesView: View {
    // states
    @State var editing = false
    @State var headerOffset: CGFloat = -100
    @State var showingSearchList = false
    @State var search = ""
    @State var searching = false
    @EnvironmentObject var tabSelection: TabSelection
    @EnvironmentObject var cityViewModel: CityViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        // nav
        ZStack {
            // background
            Color("background").edgesIgnoringSafeArea(.all)
            
            // scroll
            ScrollView {
                VStack (spacing: 20) {
                    // header
                    CitiesHeaderView(editing: $editing, showingSearchList: $showingSearchList, search: $search, searching: $searching)
                        .padding(.vertical)
                        .offset(y: headerOffset)
                    
                    // cities tiles
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(cityViewModel.savedCities) { city in
                            CityView(temp: Int(city.cityData.current.temp), city: city.cityName.city, country: city.cityName.country, image: cityViewModel.getWeatherImage(id: city.cityData.current.weather[0].id), rain: Int(city.cityData.daily[0].pop * 100), wind: city.cityData.current.wind_speed, showButtons: $editing)
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .blur(radius: showingSearchList ? 10 : 0)
            
            if showingSearchList {
                Color("AccentColor").edgesIgnoringSafeArea(.all)
                    .opacity(0.3)
                
                SearchView(showingSearchList: $showingSearchList)
                    .onAppear {
                        search = ""
                        searching = false
                        editing = false
                    }
            } else {
                EmptyView()
            }
        }
        // tab animatoin change
        .onChange(of: tabSelection.tab) { newValue in
            if newValue == "cities" {
                withAnimation {
                    headerOffset = 0
                }
            } else {
                headerOffset = -100
                editing = false
            }
        }
        .onAppear {
            if tabSelection.tab == "cities" {
                withAnimation {
                    headerOffset = 0
                }
            }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView()
            .environmentObject(TabSelection())
    }
}
