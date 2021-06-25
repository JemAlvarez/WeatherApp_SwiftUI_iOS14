//

import SwiftUI

struct CityView: View {
    let temp: Int
    let city: String
    let state: String
    let country: String
    let image: String
    let rain: Int
    let wind: Double
    
    @Binding public var showButtons: Bool
    @EnvironmentObject var tabSelection: TabSelection
    @State private var animate = false
    
    let widgetWidth: CGFloat = UIScreen.main.bounds.width / 2.4
    
    var body: some View {
        ZStack (alignment: .top) {
            // BOX
            VStack {
                // TOP
                HStack (alignment: .top) {
                    // LEFT
                    VStack (alignment: .leading, spacing: 0) {
                        HStack {
                            Text("\(temp)º")
                                 .font(.system(size: 35))
                        }
                        Text(city)
                            .padding(.top, 7)
                            .font(.system(size: 17))
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .lineLimit(2)
                        Text("\(state), \(country.uppercased())")
                            .padding(.top, 4)
                            .font(.system(size: 13))
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
                    SmallDataView(image: "drop", data: Text("\(rain)%"), font: .system(size: 11))
                    Spacer()
                    SmallDataView(image: "wind", data: Text("\(wind, specifier: "%.1f") mph"), font: .system(size: 11))
                    
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
                    Color.white.frame(width: 19, height: 19)
                    Image(systemName: "trash.circle.fill")
                        .foregroundColor(.red)
                }
                .rotationEffect(animate ? Angle(degrees: 20) : .zero)
                .offset(y: animate ? 1 : 0)
                .onTapGesture {
                    // delete city button
                }
            }
            .font(.system(size: 30))
            .frame(width: widgetWidth)
            .offset(x: 15,y: -15)
            .isHidden(!showButtons)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.15).repeatForever(autoreverses: true)) {
                    animate.toggle()
                }
            }
            
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(temp: 22, city: "Austin", state: "TX", country: "usa", image: "clear_sky", rain: 27, wind: 4.4, showButtons: .constant(true))
            .environmentObject(TabSelection())
    }
}
