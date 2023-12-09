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
        .padding([.horizontal], 100)
    }
}

#Preview {
    CardView(asyncImageName: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg")
}
