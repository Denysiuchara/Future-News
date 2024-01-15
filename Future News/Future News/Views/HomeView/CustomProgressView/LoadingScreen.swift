//
//  EmptyNewsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 20.12.2023.
//

import SwiftUI

struct LoadingScreen: View {
    @Environment(\.screenSize) private var screenSize
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("news_blank_image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 0.90, height: geo.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                CustomLoadingView(cornerRadius: 20, lineWidth: 5, duration: 5)
                    .frame(width: geo.size.width * 0.90 - 8, height: geo.size.height - 8)
                
            }
            .frame(width: geo.size.width)
        }
        .frame(height: 300)
        
        Divider()
        
        GIFView(fileName: "dragon")
            .background {
                Color.clear
            }
            .frame(width: screenSize.width, height: screenSize.width)
            .padding()
    }
}

#Preview {
    LoadingScreen()
}
