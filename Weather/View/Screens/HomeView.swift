//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                VStack {
                    Text("Home")
                }
                .frame(height: (UIScreen.main.bounds.height - (UIScreen.main.bounds.height * 0.12)))
                Spacer()
            }
        }.foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
