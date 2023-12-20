
import SwiftUI


struct UnderlineModifier: ViewModifier {
    var selectedIndex: Int
    let frames: [CGRect]

    func body(content: Content) -> some View {
        content
            .background(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.orange)
                    .frame(width: frames[selectedIndex].width, height: 4)
                    .offset(x: frames[selectedIndex].minX - frames[0].minX)
                }
            .animation(.snappy(duration: 0.4))
    }
}
