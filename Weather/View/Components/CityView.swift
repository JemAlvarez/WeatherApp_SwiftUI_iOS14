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
    
    @State private var animate = false
    
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
                    Image(systemName: "drop")
                        .foregroundColor(Color("lightBlue"))
                    Text("\(rain)%")
                    Spacer()
                    Image(systemName: "wind")
                        .foregroundColor(Color("lightBlue"))
                    Text("\(wind, specifier: "%.1f") mph")
                }
                .font(.caption2)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
            }
            .frame(width: UIScreen.main.bounds.width / 2.4, height: UIScreen.main.bounds.width / 2.4)
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
                
                ZStack {
                    Color.white.frame(width: 15, height: 15)
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                }
                .rotationEffect(animate ? Angle(degrees: 20) : .zero)
                .offset(y: animate ? 1 : 0)
            }
            .font(.title)
            .frame(width: UIScreen.main.bounds.width / 2.4)
            .offset(x: 15,y: -15)
            .isHidden(showButtons)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) {
                    animate.toggle()
                }
            }
            
        }
    }
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
            if hidden {
                if !remove {
                    self.hidden()
                }
            } else {
                self
            }
        }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(temp: 22, city: "Austin", country: "usa", image: "sunny", rain: 27, wind: 4.4, showButtons: .constant(false))
    }
}
