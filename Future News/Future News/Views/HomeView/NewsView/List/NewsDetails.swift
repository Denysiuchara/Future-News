//
//  NewsDetails.swift
//  Future News
//
//  Created by Danya Denisiuk on 20.12.2023.
//

import SwiftUI

struct NewsDetails: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.screenSize) private var screenSize
    
    @Binding var isSafe: Bool
    
    @State private var scrollOffset: CGFloat = 0
    @State private var isCoppied = false
    
    var news: News
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                    
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.trailing, 5)
                    
                    // TODO: - Realize "share"
                    Button{
                        isSafe.toggle()
                    } label: {
                        Image(systemName: isSafe ? "bookmark" : "bookmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.trailing, 5)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
                .foregroundStyle(.foreground)
                .padding(.horizontal)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundStyle(.newsRow)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.green)
                        .frame(width: screenSize.width * scrollOffset)
                        .animation(.easeIn, value: scrollOffset)
                }
                .frame(height: 8)
                
                VStack {
                    AsyncImage(url: URL(string: news.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ZStack {
                            Image("news_blank_image")
                                .resizable()
                                .scaledToFit()
                            
                            ProgressView()
                        }
                    }
                    .frame(width: screenSize.width)
                    
                    Text(news.title)
                        .padding(.horizontal)
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(news.author ?? "Unknown author")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .frame(width: screenSize.width, alignment: .leading)
                    
                    Text(news.publishDate)
                        .font(.subheadline)
                        .padding(.horizontal)
                        .frame(width: screenSize.width, alignment: .leading)
                }
                
                AdvancedScrollView(scrollOffset: $scrollOffset) {
                    ScrollView {
                        HStack {
                            Text("Source:")
                            
                            Text(news.url)
                                .lineLimit(1)
                                .underline()
                                .foregroundStyle(.orange)
                                .onTapGesture {
                                    if let url = URL(string: news.url), UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            
                            // TODO: - Add alert, that the text was copied
                            Button {
                                UIPasteboard.general.string = news.url
                                withAnimation(.bouncy) {
                                    isCoppied.toggle()
                                }
                            } label: {
                                Image(systemName: isCoppied ? "doc" : "doc.fill")
                            }
                        }
                        .padding(.horizontal)
                        .frame(width: screenSize.width)
                        
                        Text(news.text)
                            .padding()
                    }
                }
            }
            .fontDesign(.rounded)
            .tint(.orange)
        }
    }
}

#Preview {
    NewsDetails(isSafe: .constant(true), news: News(id: 123124132414,
                                                    title: "ПВО днем уничтожила управляемую ракету на Днепропетровщине",
                                                    text: "В Днепропетровской области днем 20 декабря Воздушные силы уничтожили российскую управляемую авиационную ракету.В Днепровском районе Днепропетровской области подразделением Воздушное командование Восток уничтожено управляемую авиационную ракету Х-59 Что этому предшествовало: Днем 20 декабря Воздушные силы сообщили о масштабной воздушной тревоге из-за угрозы применения Россией баллистического вооружения.В Днепропетровской области днем 20 декабря Воздушные силы уничтожили российскую управляемую авиационную ракету.В Днепровском районе Днепропетровской области подразделением Воздушное командование Восток уничтожено управляемую авиационную ракету Х-59 Что этому предшествовало: Днем 20 декабря Воздушные силы сообщили о масштабной воздушной тревоге из-за угрозы применения Россией баллистического вооружения.В Днепропетровской области днем 20 декабря Воздушные силы уничтожили российскую управляемую авиационную ракету.В Днепровском районе Днепропетровской области подразделением Воздушное командование Восток уничтожено управляемую авиационную ракету Х-59 Что этому предшествовало: Днем 20 декабря Воздушные силы сообщили о масштабной воздушной тревоге из-за угрозы применения Россией баллистического вооружения.В Днепропетровской области днем 20 декабря Воздушные силы уничтожили российскую управляемую авиационную ракету.В Днепровском районе Днепропетровской области подразделением Воздушное командование Восток уничтожено управляемую авиационную ракету Х-59 Что этому предшествовало: Днем 20 декабря Воздушные силы сообщили о масштабной воздушной тревоге из-за угрозы применения Россией баллистического вооружения.В Днепропетровской области днем 20 декабря Воздушные силы уничтожили российскую управляемую авиационную ракету.В Днепровском районе Днепропетровской области подразделением Воздушное командование Восток уничтожено управляемую авиационную ракету Х-59 Что этому предшествовало: Днем 20 декабря Воздушные силы сообщили о масштабной воздушной тревоге из-за угрозы применения Россией баллистического вооружения.В Днепропетровской области днем 20 декабря Воздушные силы уничтожили российскую управляемую авиационную ракету.В Днепровском районе Днепропетровской области подразделением Воздушное командование Восток уничтожено управляемую авиационную ракету Х-59 Что этому предшествовало: Днем 20 декабря Воздушные силы сообщили о масштабной воздушной тревоге из-за угрозы применения Россией баллистического вооружения.В Днепропетровской области днем 20 декабря Воздушные силы уничтожили российскую управляемую авиационную ракету.В Днепровском районе Днепропетровской области подразделением Воздушное командование Восток уничтожено управляемую авиационную ракету Х-59 Что этому предшествовало: Днем 20 декабря Воздушные силы сообщили о масштабной воздушной тревоге из-за угрозы применения Россией баллистического вооружения.",
                                                    url: "https://www.facebook.com/pvkshid/posts/pfbid02QU2pc58hJowb1HBAXFUUNDSdL5oKVLxui6guLgRhSzVPgMzpxcXrLsvPhDWTpiqwl",
                                                    image: "https://media.istockphoto.com/id/1311148884/vector/abstract-globe-background.jpg?s=612x612&w=0&k=20&c=9rVQfrUGNtR5Q0ygmuQ9jviVUfrnYHUHcfiwaH5-WFE=",
                                                    publishDate: "20.12.2023 17:51",
                                                    language: "uk",
                                                    sourceCountry: "Ukraine",
                                                    sentiment: 0.4,
                                                    author: "АЛЕКСАНДР ШУМИЛИН"))
}
