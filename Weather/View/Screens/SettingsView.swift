//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                VStack {
                    Text("Settings")
                }
                .frame(height: (UIScreen.main.bounds.height - (UIScreen.main.bounds.height * 0.12)))
                Spacer()
            }
        }.foregroundColor(.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
