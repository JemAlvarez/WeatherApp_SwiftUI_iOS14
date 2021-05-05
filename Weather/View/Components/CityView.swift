//

import SwiftUI

struct CityView: View {
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        Text("22")
                             .font(.largeTitle)
                         Text("º")
                            .font(.title)
                            .offset(x: -7, y: -12)
                    }
                    Text("Austin")
                        .padding(.top, 7)
                        .font(.headline)
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    Text("USA")
                        .padding(.top, 4)
                        .font(.footnote)
                        .opacity(0.5)
                }
                
                Spacer()
                
                VStack {
                    LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        .frame(height: (UIScreen.main.bounds.width / 2.5) / 3.3)
                        .mask(Image(systemName: "moon")
                                .font(.largeTitle))
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            Spacer()
            
            HStack {
                Image(systemName: "drop")
                    .foregroundColor(Color("lightBlue"))
                Text("27%")
                Spacer()
                Image(systemName: "wind")
                    .foregroundColor(Color("lightBlue"))
                Text("4.4 mph")
            }
            .font(.footnote)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
        }
        .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.width / 2.3)
//        .padding()
        .background(Color("backgroundLight"))
        .cornerRadius(15)
        .foregroundColor(.white)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
