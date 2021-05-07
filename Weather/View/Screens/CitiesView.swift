//

import SwiftUI

struct CitiesView: View {
    @State var editing = true
    @State var animate = false
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                VStack (spacing: 20) {
                    Button (action: {
                        editing.toggle()
                    }) {
                        Image(systemName: "pencil")
                    }
                    .padding(.vertical, 50)
                    
                    HStack {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "sunny", rain: 27, wind: 4.4, showButtons: $editing)
                        Spacer()
                        CityView(temp: 22, city: "Austin", country: "usa", image: "thunderstorm", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                    HStack {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "cloudySun", rain: 27, wind: 4.4, showButtons: $editing)
                        Spacer()
                        CityView(temp: 22, city: "Austin", country: "usa", image: "moon", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                    HStack {
                        CityView(temp: 22, city: "Austin", country: "usa", image: "moon", rain: 27, wind: 4.4, showButtons: $editing)
                        Spacer()
                        CityView(temp: 22, city: "Austin", country: "usa", image: "thunderstorm", rain: 27, wind: 4.4, showButtons: $editing)
                    }
                    Spacer()
                }
                .padding(.horizontal, 25)
                .frame(height: (UIScreen.main.bounds.height - (UIScreen.main.bounds.height * 0.12)))
                Spacer()
            }
        }.foregroundColor(.white)
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView()
    }
}
