//

import SwiftUI

struct SearchListView: View {
    @State var searchTerm: String
    
    var body: some View {
        CustomScreenView {
            Text(searchTerm)
        } background: {
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }

    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(searchTerm: "A")
    }
}
