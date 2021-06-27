//

import SwiftUI

struct MinutePrecipitationView: View {
    @EnvironmentObject var tabSelection: TabSelection
    @State var maxHeight = false
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                Text("Rain for the next hour.")
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack (spacing: 3) {
                    ForEach (0..<tempMinutely.minutely.count, id: \.self) { i in
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: maxHeight ? (metrics.size.height * (CGFloat(tempMinutely.minutely[i].precipitation / getMax()))) * 0.5 : 0)
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
        .foregroundColor(Color.white)
        .onChange(of: tabSelection.tab) { newTab in
            if newTab == "home" {
                withAnimation {
                    maxHeight = true
                }
            } else {
                maxHeight = false
            }
        }
        .onAppear {
            if tabSelection.tab == "home" {
                withAnimation {
                    maxHeight = true
                }
            }
        }
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
            .environmentObject(TabSelection())
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
