//
//  CardView.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct CardView: View {
    
    var asyncImageName: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AsyncImage(url: URL(string: asyncImageName)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width * 0.90, height: geo.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                } placeholder: {
                    Image("news-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width * 0.90, height: geo.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                VStack {
                    
                    Spacer()
                    
                    Text("**Some color to fill in the string!Some color to fill in the string!Some color to fill**")
                        .fontDesign(.rounded)
                        .lineLimit(2)
                        .foregroundStyle(.white)
                        .frame(width: geo.size.width * 0.83, height: 60, alignment: .leading)
                        .padding()
                        .background {
                            VisualEffectView(style: .systemThinMaterialDark, alpha: 1.0)
                                .opacity(0.5)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.25)
                        }
                        .padding(.bottom, 25)
                        
                }
            }
            .frame(width: geo.size.width)
        }
    }
}

#Preview {
    CardView(asyncImageName: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg")
        .frame(height: 300)
}
