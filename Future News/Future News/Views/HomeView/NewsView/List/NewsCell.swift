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
    @Binding var isSafeNews: Bool
    @Binding var dynamicSize: CGFloat
    @Binding var isPresentedNewsDetails: Bool
    
    var news: News
    
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
                
                // FIXME: - Пофиксить баг: при нажатии перекрашиваются все row
                Button {
                    withAnimation(.spring(duration: 0.4, bounce: 0.0, blendDuration: 1)) {
                        isSafeNews.toggle()
                        dynamicSize = isSafeNews ? 23 : 20
                    }
                } label: {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenSize.width * 0.07, height: screenSize.width * 0.07)
                        .foregroundStyle(isSafeNews ? .orange : .black)
                }
                .frame(width: screenSize.width * 0.1, height: screenSize.width * 0.1)
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
            NewsDetails(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails, isSafeNews: $isSafeNews, news: news)
        }
        .padding(.bottom)
    }
}

#Preview {
    NewsCell(
        isPresentedPreviewNewsDetails: .constant(false),
        isSafeNews: .constant(true),
        dynamicSize: .constant(20),
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
