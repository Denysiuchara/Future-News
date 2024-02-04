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
        ZStack {
            Color.colorSet3.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ZStack {
                        Image("news_blank_image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenSize.width * 0.95,
                                   height: screenSize.height * 0.35,
                                   alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        CustomLoadingView(cornerRadius: 12, lineWidth: 5, duration: 5)
                            .frame(width: (screenSize.width * 0.95) - 10,
                                   height: (screenSize.height * 0.35) - 10,
                                   alignment: .center)
                        
                    }
                    
                    Divider()
                    
                    GIFView(fileName: "dragon")
                        .background {
                            Color.clear
                        }
                        .frame(width: screenSize.width * 0.8,
                               height: screenSize.width * 0.8)
                        .padding(.bottom)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    LoadingScreen()
}
