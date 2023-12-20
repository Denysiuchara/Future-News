
import SwiftUI

struct RectPreferenceKey: PreferenceKey {
    
    static var defaultValue = CGRect.zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
