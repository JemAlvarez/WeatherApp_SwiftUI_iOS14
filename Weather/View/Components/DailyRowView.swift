//

import SwiftUI

struct DailyRowView: View {
    let day: String
    let image: String
    let tempLow: String
    let tempHigh: String
    let pop: Int?
    
    var body: some View {
        HStack {
            Text(day)
                .frame(width: 90, alignment: .leading)
            
            Spacer()
            
            ZStack {
                if pop != nil {
                    Text("\(pop!)%")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 15))
                        .padding(0)
                        .offset(x: -50)
                }
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
            }
            
            Spacer()
            
            HStack {
                Text("\(tempLow)º")
                Text("/")
                    .opacity(0.5)
                Text("\(tempHigh)º")
                    .opacity(0.5)
            }
            .frame(width: 80)
            .font(.system(size: 17))
        }
    }
}

struct DailyRowView_Previews: PreviewProvider {
    static var previews: some View {
        DailyRowView(day: "Wednesday", image: "clear_sky", tempLow: "19", tempHigh: "15", pop: 20)
    }
}
