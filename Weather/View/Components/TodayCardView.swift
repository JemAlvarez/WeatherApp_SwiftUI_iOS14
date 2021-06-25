//

import SwiftUI

struct TodayCardView: View {
    let time: String
    let image: String
    let temp: String
    let pop: Int?
    
    var body: some View {
        VStack {
            Text(time)
                .font(.system(size: 13))
            
            Spacer()
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            if pop != nil {
                Text("\(pop!)%")
                    .font(.system(size: 15))
                    .foregroundColor(.accentColor)
                    .padding(0)
            }
            
            Spacer()
            
            Text(temp)
                .font(.system(size: 22))
        }
        .frame(height: 110)
    }
}

struct TodayCardView_Previews: PreviewProvider {
    static var previews: some View {
        TodayCardView(time: "10 AM", image: "clear_sky", temp: "19º", pop: 20)
    }
}
