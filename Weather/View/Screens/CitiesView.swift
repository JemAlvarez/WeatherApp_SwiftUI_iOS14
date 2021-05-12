//

import SwiftUI

struct CitiesView: View {
    @State var editing = true
    @State var animate = false
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                VStack (spacing: 20) {
                    CitiesHeaderView(editing: $editing)
                        .padding(.vertical)
                    
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
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
            }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView()
    }
}
