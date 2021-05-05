//

import SwiftUI

struct CitiesView: View {
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                VStack (spacing: 25) {
                    HStack {
                        CityView()
                        Spacer()
                        CityView()
                    }
                    HStack {
                        CityView()
                        Spacer()
                        CityView()
                    }
                    HStack {
                        CityView()
                        Spacer()
                        CityView()
                    }
                    Spacer()
                }
                .padding(.horizontal)
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
