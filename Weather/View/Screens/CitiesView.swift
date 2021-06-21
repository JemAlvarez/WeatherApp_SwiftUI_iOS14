//

import SwiftUI

struct CitiesView: View {
    // states
    @State var editing = true
    @State var headerOffset: CGFloat = -100
    @EnvironmentObject var tabSelection: TabSelection
    
    var body: some View {
        // nav
        NavigationView {
            ZStack {
                // background
                Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                // scroll
                ScrollView {
                    VStack (spacing: 20) {
                        // header
                        CitiesHeaderView(editing: $editing)
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
            }            // hide nav title
            .navigationTitle("Cities")
            .navigationBarHidden(true)
        }
        // tab animatoin change
        .onChange(of: tabSelection.tab) { newValue in
            if newValue == "cities" {
                withAnimation {
                    headerOffset = 0
                }
            } else {
                headerOffset = -100
                editing = true
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
    }
}
