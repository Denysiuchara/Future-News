
import SwiftUI

class ScreenSizeEnvironmentKey: EnvironmentKey {
    static let defaultValue: CGSize = UIScreen.main.bounds.size
}
