//

import SwiftUI

struct HomeView: View {
    var body: some View {
        // view
        CustomScreenView(customScreen: {
            Text("HOME")
        }, background: {
            // view background
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
