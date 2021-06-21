//

import SwiftUI

struct TodayCardView: View {
    let time: String
    let image: String
    let temp: String
    
    var body: some View {
        VStack {
            Text(time)
                .font(.footnote)
            
            Spacer()
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            Spacer()
            
            Text(temp)
                .font(.title2)
        }
        .frame(height: 110)
    }
}

struct TodayCardView_Previews: PreviewProvider {
    static var previews: some View {
        TodayCardView(time: "10 AM", image: "clear_sky", temp: "19º")
    }
}
