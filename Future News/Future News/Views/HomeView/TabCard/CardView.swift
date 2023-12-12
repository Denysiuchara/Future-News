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
        GeometryReader { geo in
            ZStack {
                AsyncImage(url: URL(string: asyncImageName)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width * 0.90, height: geo.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray)
                        .frame(width: geo.size.width * 0.90, height: geo.size.height)
                }
                
                VStack {
                    HStack {
                        FixedSpacer(width: geo.size.width * 0.7, height: 1)
                        
                        Button {
                            isSelected.toggle()
                        } label: {
                            Image(systemName: isSelected ? "bookmark.fill" : "bookmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.orange)
                        }
                        .background {
                            VisualEffectView(style: .systemThinMaterialDark)
                                .opacity(0.7)
                                .clipShape(Circle())
                                .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.15)
                        }
                    }
                    
                    FixedSpacer(width: 1, height: geo.size.width * 0.3)
                    
                    Text("**Some color to fill in the string!Some color to fill in the string!Some color to fill**")
                        .fontDesign(.rounded)
                        .lineLimit(2)
                        .foregroundStyle(.white)
                        .frame(width: geo.size.width * 0.83, height: 60, alignment: .leading)
                        .padding()
                        .background {
                            VisualEffectView(style: .systemThinMaterialDark)
                                .opacity(0.5)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.25)
                        }
                }
            }
            .frame(width: geo.size.width)
        }
    }
}

private struct FixedSpacer: View {
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
