//

import SwiftUI

struct MinutePrecipitationView: View {
    var body: some View {
        VStack {
            GeometryReader {metrics in
                VStack {
                    Text("Rain for the next hour.")
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    HStack (spacing: 3) {
                        ForEach (0..<tempMinutely.minutely.count, id: \.self) { i in
                            VStack {
                                Spacer()
                                Rectangle()
                                    .frame(width: metrics.size.width / 120, height: (metrics.size.height * (CGFloat(tempMinutely.minutely[i].precipitation / getMax()))) * 0.6)
                                    .cornerRadius(5)
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        ForEach (0..<6) { i in
                            if i == 0 {
                                Text("Now")
                            } else {
                                Text("\(i * 10)m")
                            }
                            Spacer()
                        }
                    }
                    .opacity(0.4)
                }
            }
            .frame(height: 150)
            .padding()
            .background(Color("backgroundLight"))
            .cornerRadius(20)
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color("background"))
        .foregroundColor(Color.white)
    }
    
    func getMax () -> Double {
        var max: Double = 0
        
        for min in tempMinutely.minutely {
            if min.precipitation > max {
                max = min.precipitation
            }
        }
        
        return max
    }
}

struct MinutePrecipitationView_Previews: PreviewProvider {
    static var previews: some View {
        MinutePrecipitationView()
    }
}

struct tempMinutely {
    static let minutely = [
        Minutely(precipitation: 2),
        Minutely(precipitation: 3),
        Minutely(precipitation: 4),
        Minutely(precipitation: 4),
        Minutely(precipitation: 2),
        Minutely(precipitation: 5),
        Minutely(precipitation: 6),
        Minutely(precipitation: 2),
        Minutely(precipitation: 6),
        Minutely(precipitation: 7),
        Minutely(precipitation: 8),
        Minutely(precipitation: 2),
        Minutely(precipitation: 6),
        Minutely(precipitation: 5),
        Minutely(precipitation: 6),
        Minutely(precipitation: 4),
        Minutely(precipitation: 5),
        Minutely(precipitation: 6),
        Minutely(precipitation: 6),
        Minutely(precipitation: 2),
        Minutely(precipitation: 7),
        Minutely(precipitation: 8),
        Minutely(precipitation: 5),
        Minutely(precipitation: 3),
        Minutely(precipitation: 2),
        Minutely(precipitation: 3),
        Minutely(precipitation: 4),
        Minutely(precipitation: 4),
        Minutely(precipitation: 2),
        Minutely(precipitation: 5),
        Minutely(precipitation: 6),
        Minutely(precipitation: 2),
        Minutely(precipitation: 6),
        Minutely(precipitation: 7),
        Minutely(precipitation: 8),
        Minutely(precipitation: 2),
        Minutely(precipitation: 2),
        Minutely(precipitation: 3),
        Minutely(precipitation: 4),
        Minutely(precipitation: 4),
        Minutely(precipitation: 2),
        Minutely(precipitation: 5),
        Minutely(precipitation: 6),
        Minutely(precipitation: 2),
        Minutely(precipitation: 6),
        Minutely(precipitation: 7),
        Minutely(precipitation: 8),
        Minutely(precipitation: 2),
        Minutely(precipitation: 6),
        Minutely(precipitation: 5),
        Minutely(precipitation: 6),
        Minutely(precipitation: 4),
        Minutely(precipitation: 5),
        Minutely(precipitation: 6),
        Minutely(precipitation: 6),
        Minutely(precipitation: 2),
        Minutely(precipitation: 7),
        Minutely(precipitation: 8),
        Minutely(precipitation: 5),
        Minutely(precipitation: 3)
    ]
}
