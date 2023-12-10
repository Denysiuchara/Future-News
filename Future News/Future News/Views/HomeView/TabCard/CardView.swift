//
//  CardView.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct CardView: View {
    @Binding var isSelected: Bool
    var asyncImageName: String
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: asyncImageName)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 230)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
            } placeholder: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.gray)
                    .frame(width: 300, height: 230)
            }
            
            VStack {
                HStack {
                    Text("2 hours ago")

                    Button {
                        isSelected.toggle()
                    } label: {
                        Image(systemName: isSelected ? "bookmark.fill" : "bookmark")

                    }
                }
                
                FixedSpacer(width: 1, height: 100)
                
                Text("Some color to fill in the string!Some color to fill ")

            }
        }
    }
}

struct FixedSpacer: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .frame(width: width, height: height)
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    let blur: UIBlurEffect

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: blur)
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = blur
    }
}


struct VisualEffectView: View {
    var style: UIBlurEffect.Style
    
    var body: some View {
        let blur = UIBlurEffect(style: style)
        return VisualEffectBlur(blur: blur)
    }
}

#Preview {
    CardView(isSelected: Binding(projectedValue: .constant(false)), asyncImageName: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg")
}
