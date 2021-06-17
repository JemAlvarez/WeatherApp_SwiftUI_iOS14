//

import SwiftUI


struct CustomScreenView <CustomScreen : View, Background : View> : View {
    var customScreen : CustomScreen
    var background : Background
    
    init(@ViewBuilder customScreen: () -> CustomScreen, background: () -> Background) {
        self.customScreen = customScreen()
        self.background = background()
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            background
            
            VStack {
                customScreen
            }
            .frame(height: miscData.viewHeight)
        }
    }
}

//struct CustomScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomScreenView {
//            Text("A")
//        }
//    }
//}
