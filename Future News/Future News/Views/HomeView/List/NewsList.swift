//
//  NewsList.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct NewsList: View {
    @Binding var isSafe: Bool
    
    var news: [News]
    
    @State private var dynamicSize: CGFloat = 20
    @State private var isPresented = false
    
    private let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        
        // FIXME: - Пераработать макет размеров, чтобы он подганялся под разный размер девайсов
        ForEach(news.indices) { index in
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(news[index].author ?? "Unknown author")
                            .font(.system(size: 23))
                            .lineLimit(2)
                            .fontWeight(.bold)
                            .padding(.top, 6)
                        
                        Text(news[index].publishDate)
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
                    AsyncImage(url: URL(string: news[index].image)) { image in
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
                    
                    Text(news[index].title)
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
                isPresented.toggle()
            }
            .fullScreenCover(isPresented: $isPresented) {
                NewsDetails(isSafe: $isSafe, news: news[index])
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    NewsList(isSafe: .constant(false), news: [News(id: 1,
                                                   title: "Some Title",
                                                   text: "Some text",
                                                   url: "url",
                                                   image: "url_image",
                                                   publishDate: "12-12-12 12:12",
                                                   language: "sm",
                                                   sourceCountry: "Some Country",
                                                   sentiment: 0.1,
                                                   author: "Some Author")])
}
