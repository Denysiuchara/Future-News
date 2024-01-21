//
//  NewsCell.swift
//  Future News
//
//  Created by Danya Denisiuk on 20.01.2024.
//

import SwiftUI

struct NewsCell: View {
    @Environment(\.screenSize) private var screenSize
    
    @Binding var isPresentedPreviewNewsDetails: Bool
    @Binding var isSaveNews: Bool
    @Binding var isPresentedNewsDetails: Bool
    
    var news: News
    
    @State private var dynamicSize: CGFloat = 28
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(news.title)
                        .font(.system(size: 23))
                        .lineLimit(2)
                        .fontWeight(.bold)
                        .padding(.top, 6)
                    
                    Text(news.publishDate)
                        .fontDesign(.rounded)
                        .frame(width: screenSize.width * 0.50, height: 20, alignment: .leading)
                        .opacity(0.5)
                        .font(.system(size: 13))
                }
                
                Spacer()
                
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 2)
                    withAnimation(.spring(duration: 0.4, bounce: 0.0, blendDuration: 1)) {
                        isSaveNews.toggle()
                        dynamicSize = isSaveNews ? 33 : 28
                    }
                } label: {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: dynamicSize, height: dynamicSize)
                        .foregroundStyle(isSaveNews ? .orange : .black)
                }
                .frame(width: 30, height: 30)
            }
            .padding(.horizontal)
            .frame(width: screenSize.width)
            
            VStack {
                AsyncImage(url: URL(string: news.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .shadow(radius: 10)
                        .frame(width: screenSize.width - (screenSize.width * 0.05),
                               height: screenSize.width - (screenSize.width * 0.36))
                        .clipped()
                } placeholder: {
                    Image("news_blank_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenSize.width - (screenSize.width * 0.05),
                               height: screenSize.width - (screenSize.width * 0.36))
                        .clipped()
                }
                
                Text(news.author ?? "Unknown author")
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .lineLimit(3)
                    .frame(width: 370, alignment: .topLeading)
            }
        }
        .background {
            GeometryReader { geo in
                Rectangle()
                    .fill(.newsRow)
                    .frame(width: geo.size.width, height: geo.size.height + 10)
                    .shadow(radius: 10)
            }
        }
        .onTapGesture {
            isPresentedNewsDetails.toggle()
        }
        .fullScreenCover(isPresented: $isPresentedNewsDetails) {
            NewsDetails(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails, isSaveNews: $isSaveNews, news: news)
        }
        .padding(.bottom)
    }
}

#Preview {
    NewsCell(
        isPresentedPreviewNewsDetails: .constant(false),
        isSaveNews: .constant(true),
        isPresentedNewsDetails: .constant(false),
        news: News(id: 1,
                   title: "Some Title",
                   text: "Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text Some text",
                   url: "url",
                   image: "url_image",
                   publishDate: "12-12-12 12:12",
                   language: "sm",
                   sourceCountry: "Some Country",
                   sentiment: 0.1,
                   author: "Some Author")
    )
}
