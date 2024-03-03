
import SwiftUI

struct SegmentedButtonView: View {
    @Binding private var selectedIndex: Int
    @Binding private var frames: [CGRect]
    @Binding private var backgroundFrame: CGRect

    private let titles: [String]
    let checkIsScrollable: (() -> Void)

    init(selectedIndex: Binding<Int>,
         frames: Binding<[CGRect]>,
         backgroundFrame: Binding<CGRect>,
         checkIsScrollable: (@escaping () -> Void),
         titles: [String]) {
        
        _selectedIndex = selectedIndex
        _frames = frames
        _backgroundFrame = backgroundFrame

        self.checkIsScrollable = checkIsScrollable
        self.titles = titles
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(titles.indices, id: \.self) { index in
                Button {
                    selectedIndex = index
                    print("Selected Idex = \(selectedIndex)")
                } label: {
                    Text(titles[index])
                        .fontWeight(.semibold)
                        .foregroundStyle(index == selectedIndex ? .black : .gray)
                        .fontDesign(.rounded)
                }
                .id(selectedIndex)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background {
                    GeometryReader { geo in
                        Color.clear.preference(key: RectPreferenceKey.self, value: geo.frame(in: .global))
                            .onPreferenceChange(RectPreferenceKey.self) {
                                self.setFrame(index: index, frame: $0)
                            }
                    }
                }
            }
        }
        .modifier(UnderlineModifier(selectedIndex: selectedIndex, frames: frames))
    }

    // Задает размер для Подчеркивания
    private func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame

        checkIsScrollable()
    }
}
