//
//  PreviewNewsDetails.swift
//  Future News
//
//  Created by Danya Denisiuk on 21.01.2024.
//

import SwiftUI

struct PreviewNewsDetails: View {
    @Environment(\.screenSize) private var screenSize
    
    @Binding var isPresentedPreviewNewsDetails: Bool
    @Binding var isSaveNews: Bool
    @Binding var isPresentedNewsDetails: Bool
    
    @State private var dynamicSize: CGFloat = 28
    
    var news: News
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation {
                            self.isPresentedPreviewNewsDetails = false
                        }
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.black)
                            .frame(width: isPresentedPreviewNewsDetails ? 30 : 0,
                                   height: isPresentedPreviewNewsDetails ? 30 : 0)
                    }
                    .padding([.horizontal, .top])
                    
                }
                
                Divider()
            }
            .frame(width: screenSize.width,
                   height: isPresentedPreviewNewsDetails ? 45 : 0)
            .scaleEffect(CGSize(width: isPresentedPreviewNewsDetails ? 1 : 0,
                                height: isPresentedPreviewNewsDetails ? 1 : 0),
                         anchor: .bottom)
            
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
                        isSaveNews.toggle()
                        dynamicSize = isSaveNews ? 33 : 28
                    }
                } label: {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenSize.width * 0.07, height: screenSize.width * 0.07)
                        .foregroundStyle(isSaveNews ? .orange : .black)
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
                
                VStack {
                    Divider()
                    
                    Text(news.text)
                        .lineLimit(7)
                        .frame(height: isPresentedPreviewNewsDetails ? 200 : 0, alignment: .topLeading)
                        .padding(.horizontal)
                        .scaleEffect(CGSize(width: isPresentedPreviewNewsDetails ? 1 : 0,
                                            height: isPresentedPreviewNewsDetails ? 1 : 0),
                                     anchor: .topLeading)
                    
                    Button {
                        isPresentedNewsDetails.toggle()
                    } label: {
                        Text("Read the full news")
                            .foregroundStyle(.black)
                    }
                    .padding(7)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange)
                    }
                    .shadow(radius: 4)

                }
                .frame(width: screenSize.width,
                       height: isPresentedPreviewNewsDetails ? 250 : 0)
                .scaleEffect(CGSize(width: isPresentedPreviewNewsDetails ? 1 : 0,
                                    height: isPresentedPreviewNewsDetails ? 1 : 0),
                             anchor: .top)
            }
        }
        .background {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: isPresentedPreviewNewsDetails ? 20 : 0)
                    .fill(.newsRow)
                    .frame(width: geo.size.width, height: geo.size.height + 10)
                    .shadow(radius: 10)
            }
        }
        .scaleEffect(CGSize(width: isPresentedPreviewNewsDetails ? 0.97 : 1,
                            height: isPresentedPreviewNewsDetails ? 0.97 : 1),
                     anchor: .center)
        .fullScreenCover(isPresented: $isPresentedNewsDetails) {
            NewsDetails(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                        isSaveNews: $isSaveNews,
                        news: news)
        }
        .padding(.bottom)
    }
}

#Preview {
    PreviewNewsDetails(
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
