//

import SwiftUI

struct SearchView: View {
    @State var city: String
    @Binding var showingSearchList: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        showingSearchList = false
                    }
                }) {
                    Text("Cancel")
                        .bold()
                }
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("Add")
                        .bold()
                }
            }
            .foregroundColor(.white)
            
            CityView(temp: 22, city: "Florida", country: "USA", image: "snow", rain: 28, wind: 2.456, showButtons: .constant(false))
        }
        .padding()
        .background(Color("backgroundLight"))
        .cornerRadius(20)
        .padding(.horizontal, 50)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(city: "Blue", showingSearchList: .constant(true))
    }
}
