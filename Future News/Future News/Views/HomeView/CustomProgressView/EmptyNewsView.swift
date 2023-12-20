//
//  EmptyNewsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 20.12.2023.
//

import SwiftUI

struct EmptyNewsView: View {
    var body: some View {
        ZStack {
            ScrollView {
                
                // TODO: - Add more information in CardView, and add destination to tap
                GeometryReader { geo in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.orange.opacity(0.65))
                            .frame(width: geo.size.width * 0.90, height: geo.size.height)
                    }
                    .frame(width: geo.size.width)
                }
                .frame(height: 300)
                
                
                HStack {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.orange.opacity(0.65))
                        .frame(width: 200, height: 50)
                        .padding(.horizontal, 4)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
                
                // TODO: - Add scrolling with news
                ForEach(0..<2) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.newsRow)
                            .opacity(0.3)
                            .frame(width: 300, height: 120)
                            .padding([.top], 20)
                            .padding([.leading], 50)
                            .padding([.trailing], 8)
                            .shadow(radius: 10)
                        
                        VStack {
                            HStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.orange.opacity(0.8))
                                    .frame(width: 100, height: 100)
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.orange.opacity(0.65))
                                    .frame(width: 200, height: 50, alignment: .topLeading)
                            }
                            HStack {
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.orange.opacity(0.65))
                                    .frame(width: 100, height: 20, alignment: .leading)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
            
            LoadingAnimation(backgroundColor: .backround)
        }
    }
}

struct LoadingAnimation: View {
    var backgroundColor: Color
    @State private var offset: CGFloat = -400
    
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(width: 30)
            .blur(radius: 30.0)
            .offset(x: offset)
            .onAppear {
                withAnimation(Animation.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                    offset = 250
                }
            }
    }
}

#Preview {
    EmptyNewsView()
}
