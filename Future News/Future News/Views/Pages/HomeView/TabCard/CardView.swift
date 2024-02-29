//
//  CardView.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var newsItem: NewsEntity
    
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { geo in
                VStack(alignment: .center) {
                    VStack {
                        Text(newsItem.title_)
                            .fontDesign(.rounded)
                            .lineLimit(2)
                            .foregroundStyle(.white)
                            .frame(width: geo.size.width,
                                   height: geo.size.height * 0.20,
                                   alignment: .topLeading)
                            .padding(.horizontal, 10)
                            .padding(.top, 8)
                            .background {
                                GeometryReader { geometry in
                                    VisualEffectView(style: .systemThinMaterialDark, alpha: 1.0)
                                        .opacity(0.6)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                    }
                    
                    AsyncImage(url: newsItem.imageURL_) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width,
                                   height: geo.size.height * 0.80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        Image("news-placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width,
                                   height: geo.size.height * 0.80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.bottom, 16)
                }
                .frame(width: geo.size.width,
                       height: geo.size.height)
            }
        }
        .padding()
        .background {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.colorSet3)
                    .shadow(radius: 7)
                    .padding(.horizontal, 6)
            }
        }
        .padding(.vertical)
    }
}
