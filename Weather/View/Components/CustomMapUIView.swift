//

import SwiftUI

struct CustomMapUIView <Content : View> : View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
        .padding(10)
        .background(Color("backgroundLight").opacity(0.8))
        .cornerRadius(10)
    }
}

struct CustomMapUI_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapUIView {
            Image(systemName: "cloud.rain.fill")
            Text("72º")
                .opacity(0.5)
        }
    }
}
