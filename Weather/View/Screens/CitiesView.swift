//

import SwiftUI

struct CitiesView: View {
    @State var editing = true
    @State var animate = false
    @State var headerOffset: CGFloat = -100
    
    @EnvironmentObject var tabSelection: TabSelection
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                VStack (spacing: 20) {
                    CitiesHeaderView(editing: $editing)
                        .padding(.vertical)
                        .offset(y: headerOffset)
                    
                    HStack (spacing: 20) {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "sunny", rain: 27, wind: 4.4, showButtons: $editing)
                        CityView(temp: 22, city: "Austin", country: "usa", image: "thunderstorm", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                    HStack (spacing: 20) {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "cloudySun", rain: 27, wind: 4.4, showButtons: $editing)
                        CityView(temp: 22, city: "Austin", country: "usa", image: "moon", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                    HStack (spacing: 20) {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "moon", rain: 27, wind: 4.4, showButtons: $editing)
                        CityView(temp: 22, city: "Austin", country: "usa", image: "thunderstorm", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .onChange(of: tabSelection.tab) { newValue in
            if newValue == "cities" {
                withAnimation {
                    headerOffset = 0
                }
            } else {
                headerOffset = -100
            }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView()
    }
}
