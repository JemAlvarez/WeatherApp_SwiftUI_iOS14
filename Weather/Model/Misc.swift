//

import Foundation
import SwiftUI

struct miscData {
    static let viewHeight = UIScreen.main.bounds.height - (UIScreen.main.bounds.height * 0.12)
}

class TabSelection: ObservableObject {
    @Published var tab = "home"
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
