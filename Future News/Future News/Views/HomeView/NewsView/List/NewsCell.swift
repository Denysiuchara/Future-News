//
//  NewsCell.swift
//  Future News
//
//  Created by Danya Denisiuk on 20.01.2024.
//

import SwiftUI

struct NewsCell: View {
    @Environment(\.screenSize) private var screenSize
    
    @State var isPreviewNewsPresented: Bool = true
    @Binding var isSafe: Bool
    @Binding var dynamicSize: CGFloat
    @Binding var isPresented: Bool
    
    var news: News
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation {
                            self.isPreviewNewsPresented = false
                        }
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.black)
                            .frame(width: isPreviewNewsPresented ? 30 : 0,
                                   height: isPreviewNewsPresented ? 30 : 0)
                    }
                    .padding([.horizontal, .top])
                    
                }
                
                Divider()
            }
            .frame(width: screenSize.width,
                   height: isPreviewNewsPresented ? 45 : 0)
            .scaleEffect(CGSize(width: isPreviewNewsPresented ? 1 : 0,
                                height: isPreviewNewsPresented ? 1 : 0),
                         anchor: .bottom)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(news.author ?? "Unknown author")
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
                        isSafe.toggle()
                        dynamicSize = isSafe ? 23 : 20
                    }
                } label: {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenSize.width * 0.07, height: screenSize.width * 0.07)
                        .foregroundStyle(isSafe ? .orange : .black)
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
                
                Text(news.title)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .lineLimit(3)
                    .frame(width: 370, alignment: .topLeading)
                
                Text(news.text)
                    .lineLimit(7) // Разрешить неограниченное количество строк
                    .frame(height: isPreviewNewsPresented ? 200 : 0, alignment: .topLeading)
                    .opacity(isPreviewNewsPresented ? 1 : 0)
                    .scaleEffect(CGSize(width: isPreviewNewsPresented ? 1 : 0,
                                        height: isPreviewNewsPresented ? 1 : 0),
                                 anchor: .topLeading)
            }
        }
        .background {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: isPreviewNewsPresented ? 20 : 0)
                    .fill(.newsRow)
                    .frame(width: geo.size.width, height: geo.size.height + 10)
                    .shadow(radius: 10)
            }
        }
        .scaleEffect(CGSize(width: isPreviewNewsPresented ? 0.97 : 1,
                            height: isPreviewNewsPresented ? 0.97 : 1),
                     anchor: .center)
        .onTapGesture {
            isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented) {
            NewsDetails(isSafe: $isSafe, news: news)
        }
        .onLongPressGesture(minimumDuration: 0.3, maximumDistance: 15) {
            print("onLongPressGesture start")
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 2)
            withAnimation {
                self.isPreviewNewsPresented.toggle()
            }
            print("onLongPressGesture finish")
        }
        .padding(.bottom)
    }
}

#Preview {
    NewsCell(
        isSafe: .constant(true),
        dynamicSize: .constant(20),
        isPresented: .constant(false),
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
