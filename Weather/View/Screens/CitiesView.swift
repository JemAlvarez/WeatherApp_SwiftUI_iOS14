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
                    HStack (spacing: 20) {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "clear_sky", rain: 27, wind: 4.4, showButtons: $editing)
                        CityView(temp: 22, city: "Austin", country: "usa", image: "thunderstorm", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                    HStack (spacing: 20) {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "few_clouds", rain: 27, wind: 4.4, showButtons: $editing)
                        CityView(temp: 22, city: "Austin", country: "usa", image: "mist", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                    HStack (spacing: 20) {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "snow", rain: 27, wind: 4.4, showButtons: $editing)
                        CityView(temp: 22, city: "Austin", country: "usa", image: "rain", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .blur(radius: showingSearchList ? 10 : 0)
            
            if showingSearchList {
                Color("AccentColor").edgesIgnoringSafeArea(.all)
                    .opacity(0.3)
                
                SearchView(city: search, showingSearchList: $showingSearchList)
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
