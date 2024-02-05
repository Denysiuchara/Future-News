
import SwiftUI

struct SegmentedView: View {
    @Binding var selectedIndex: Int
    @State private var frames: [CGRect]
    @State private var backgroundFrame = CGRect.zero
    
    private let titles: [String]
    
    init(selectedIndex: Binding<Int>, titles: [String]) {
        self._selectedIndex = selectedIndex
        self.titles = titles
        frames = Array<CGRect>(repeating: .zero, count: titles.count)
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                SegmentedButtonView(selectedIndex: $selectedIndex,
                                    frames: $frames,
                                    backgroundFrame: $backgroundFrame,
                                    checkIsScrollable: checkIsScrollable,
                                    titles: titles)
            }
        }
        .background {
            GeometryReader { geoReader in 
                Color
                    .colorSet3
                    .preference(key: RectPreferenceKey.self,
                                value: geoReader.frame(in: .global))
                .onPreferenceChange(RectPreferenceKey.self) {
                    self.setBackgroundFrame(frame: $0)
                }
            }
        }
    }
    
    // Задает размер background
    private func setBackgroundFrame(frame: CGRect) {
        backgroundFrame = frame
        checkIsScrollable()
    }
    
    private func checkIsScrollable() {
        if frames[frames.count - 1].width > .zero {
            var width = CGFloat.zero
            
            for frame in frames {
                width += frame.width
            }
        }
    }
}






#Preview {
    SegmentedView(selectedIndex: .constant(3), titles: ["Hello", "Text", "Another Text", "Large Another Text"])
}
