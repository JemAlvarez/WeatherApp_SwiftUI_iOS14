//

import SwiftUI

struct SearchListView: View {
    @Binding var searchTerm: String
    
    var body: some View {
        CustomScreenView {
            Text(searchTerm)
        } background: {
            Color("background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .onDisappear {
            searchTerm = ""
        }
    }
}

//struct SearchListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchListView(searchTerm: "A")
//    }
//}
