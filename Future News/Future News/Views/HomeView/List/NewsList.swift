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
    
    var body: some View {
        
        // FIXME: - Пераработать макет размеров, чтобы он подганялся под разный размер девайсов
        ForEach(news.indices) { index in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.newsRow)
                    .opacity(0.7)
                    .frame(width: 300, height: 120)
                    .padding([.top], 20)
                    .padding([.leading], 50)
                    .padding([.trailing], 8)
                    .shadow(radius: 10)
                    .onTapGesture {
                        isPresented.toggle()
                    }
                
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: news[index].image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 10)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.gray)
                                .frame(width: 100, height: 100)
                        }
                        
                        Text(news[index].title)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .lineLimit(2)
                            .frame(width: 200, height: 50, alignment: .topLeading)
                    }
                    HStack {
                        Spacer()
                        
                        Text(news[index].publishDate)
                            .fontDesign(.rounded)
                            .frame(width: 100, height: 20, alignment: .leading)
                            .padding(.horizontal)
                            .opacity(0.5)
                            .font(.caption)
                        
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
                                .frame(width: dynamicSize, height: dynamicSize)
                                .foregroundStyle(isSafe ? .orange : .black)
                        }
                        .frame(width: 30, height: 30)
                        .padding(.leading, 100)
                        .padding(.trailing, 10)
                        .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
            .fullScreenCover(isPresented: $isPresented) {
                NewsDetails(isSafe: $isSafe, news: news[index])
            }
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
