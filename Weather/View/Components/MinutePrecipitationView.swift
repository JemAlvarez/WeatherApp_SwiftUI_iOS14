//

import SwiftUI

struct MinutePrecipitationView: View {
    @EnvironmentObject var tabSelection: TabSelection
    @EnvironmentObject var cityViewModel: CityViewModel
    @State var maxHeight = false
    @State var maxVal: Double = 0
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                Text("Rain for the next hour.")
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack (spacing: 3) {
                    if cityViewModel.mainCity.minutely != nil {
                        ForEach (0..<cityViewModel.mainCity.minutely!.minutely.count, id: \.self) { i in
                            VStack {
                                Spacer()
                                Rectangle()
                                    .frame(height: maxHeight ? (metrics.size.height * (CGFloat(cityViewModel.mainCity.minutely!.minutely[i].precipitation / maxVal)) * 0.3) : 0)
                                    .cornerRadius(5)
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                    } else {
                        EmptyView()
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
        .frame(minHeight: 100)
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
            
            if cityViewModel.mainCity.minutely != nil {
                maxVal = getMax(cityViewModel.mainCity.minutely!.minutely)
            }
        
            print("MAX", maxVal)
        
            if cityViewModel.mainCity.minutely != nil {
                for c in cityViewModel.mainCity.minutely!.minutely {
                    print("precipitation", c.precipitation)
                    print("____", c.precipitation / maxVal)
                }
            }
        }
    }
    
    func getMax (_ minutely: [Minutely]) -> Double {
        var max: Double = 0
        
        for min in minutely {
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
