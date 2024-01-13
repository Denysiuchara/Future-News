
import SwiftUI


struct UnderlineModifier: ViewModifier {
    var selectedIndex: Int
    let frames: [CGRect]

    func body(content: Content) -> some View {
        content
            .background(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(#colorLiteral(red: 0.337254902, green: 0.1137254902, blue: 0.7490196078, alpha: 1)))
                    .frame(width: frames[selectedIndex].width, height: 4)
                    .offset(x: frames[selectedIndex].minX - frames[0].minX)
                }
            .animation(.snappy(duration: 0.4))
    }
}
