//

import SwiftUI

struct SmallDataView: View {
    let image: String
    let data: Text
    let font: Font
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(Color("lightBlue"))
            data
        }
        .font(font)
    }
}

struct SmallDataView_Previews: PreviewProvider {
    static var previews: some View {
        SmallDataView(image: "drop", data: Text("2%"), font: .caption2)
    }
}
