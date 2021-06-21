//

import SwiftUI

struct DailyRowView: View {
    let day: String
    let image: String
    let tempLow: String
    let tempHigh: String
    
    var body: some View {
        HStack {
            Text(day)
                .frame(width: 90, alignment: .leading)
            
            Spacer()
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            
            Spacer()
            
            HStack {
                Text("\(tempLow)º")
                Text("/")
                    .opacity(0.5)
                Text("\(tempHigh)º")
                    .opacity(0.5)
            }
            .frame(width: 80)
            .font(.title3)
        }
    }
}

struct DailyRowView_Previews: PreviewProvider {
    static var previews: some View {
        DailyRowView(day: "Wednesday", image: "clear_sky", tempLow: "19", tempHigh: "15")
    }
}
