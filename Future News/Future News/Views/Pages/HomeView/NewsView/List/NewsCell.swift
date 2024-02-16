//
//  NewsCell.swift
//  Future News
//
//  Created by Danya Denisiuk on 20.01.2024.
//

import SwiftUI

struct NewsCell: View {
    @Environment(\.screenSize) private var screenSize
    @ObservedObject var selectedNews: NewsEntity
    
    @State private var dynamicSize: CGFloat = 28
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(selectedNews.title_)
                        .font(.system(size: 23))
                        .lineLimit(2)
                        .fontWeight(.bold)
                        .padding(.top, 6)
                    
                    Text(selectedNews.publishDate_.publishingDifference())
                        .fontDesign(.rounded)
                        .frame(width: screenSize.width * 0.50,
                               height: 20,
                               alignment: .leading)
                        .opacity(0.5)
                        .font(.system(size: 13))
                }
                
                Spacer()
                
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 2)
                    withAnimation(.spring(duration: 0.4, bounce: 0.0, blendDuration: 1)) {
                        selectedNews.toggle()
                        selectedNews.objectWillChange.send()
                    }
                } label: {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(selectedNews.isSaveNews ? .orange : .black)
                }
                .frame(width: 30, height: 30)
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.horizontal)
            .frame(width: screenSize.width * 0.96)
            
            VStack {
                AsyncImage(url: selectedNews.imageURL_) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .shadow(radius: 10)
                        .frame(width: screenSize.width * 0.90,
                               height: screenSize.width * 0.50)
                        .clipped()
                } placeholder: {
                    Image("news_blank_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenSize.width * 0.90,
                               height: screenSize.width * 0.50)
                        .clipped()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(selectedNews.author_)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
            }
        }
        .background {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.colorSet3)
                    .frame(width: geo.size.width, height: geo.size.height + 10)
                    .shadow(radius: 7)
            }
        }
    }
}


