//

import SwiftUI

struct CityView: View {
    @State public var temp: Int
    @State public var city: String
    @State public var country: String
    @State public var image: String
    @State public var rain: Int
    @State public var wind: Double
    @Binding public var showButtons: Bool
    
    @EnvironmentObject var tabSelection: TabSelection
    @State private var animate = false
    @State private var widgetWidth: CGFloat = 0
    
    var body: some View {
        ZStack (alignment: .top) {
            // BOX
            VStack {
                // TOP
                HStack (alignment: .top) {
                    // LEFT
                    VStack (alignment: .leading, spacing: 0) {
                        HStack {
                            Text("\(temp)")
                                 .font(.largeTitle)
                             Text("º")
                                .font(.title)
                                .offset(x: -7, y: -12)
                        }
                        Text(city)
                            .padding(.top, 7)
                            .font(.headline)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        Text(country)
                            .padding(.top, 4)
                            .font(.footnote)
                            .opacity(0.5)
                    }
                    
                    Spacer()
                    
                    // RIGHT
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: (UIScreen.main.bounds.width / 2.45) / 3.3)
                    
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // BOTTOM
                HStack {
                    SmallDataView(image: "drop", data: Text("\(rain)%"), font: .caption2)
                    Spacer()
                    SmallDataView(image: "wind", data: Text("\(wind, specifier: "%.1f") mph"), font: .caption2)
                    
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
            }
            .frame(width: widgetWidth, height: widgetWidth)
            .background(Color("backgroundLight"))
            .cornerRadius(15)
            .foregroundColor(.white)
            
            // Buttons
            HStack {
                Spacer()
                
                ZStack {
                    Color.white.frame(width: 15, height: 15)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
                .rotationEffect(animate ? Angle(degrees: 20) : .zero)
                .offset(y: animate ? 1 : 0)
                .onTapGesture {
                    // set city button
                }
                
                ZStack {
                    Color.white.frame(width: 15, height: 15)
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                }
                .rotationEffect(animate ? Angle(degrees: 20) : .zero)
                .offset(y: animate ? 1 : 0)
                .onTapGesture {
                    // delete city button
                }
            }
            .font(.title)
            .frame(width: widgetWidth)
            .offset(x: 15,y: -15)
            .isHidden(showButtons)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.15).repeatForever(autoreverses: true)) {
                    animate.toggle()
                }
            }
            
        }
        .onChange(of: tabSelection.tab) {newValue in
            if newValue == "cities" {
                withAnimation {
                    widgetWidth = UIScreen.main.bounds.width / 2.4
                }
            } else {
                widgetWidth = (UIScreen.main.bounds.width / 2.4) / 1.2
            }
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(temp: 22, city: "Austin", country: "usa", image: "sunny", rain: 27, wind: 4.4, showButtons: .constant(false))
    }
}
