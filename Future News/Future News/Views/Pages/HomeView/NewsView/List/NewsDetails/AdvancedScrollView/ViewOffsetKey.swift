
import SwiftUI

// Реализация PreferenceKey для отслеживания оффсета прокрутки
struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
