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
                
                VStack {
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
                        
                        // MARK: - Share button
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .padding(.trailing, 5)
                        
                        
                        //  MARK: - Save button
                        Button{
                            isSafe.toggle()
                        } label: {
                            Image(systemName: isSafe ? "bookmark" : "bookmark.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .padding(.trailing, 5)
                        
                        //  MARK: - Call menu button
                        MenuView(isCoppied: $isCoppied, sourceURL: news.url)
                    }
                    .foregroundStyle(.foreground)
                    .padding(.horizontal)
                }
                .padding(.bottom)
                .background {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundStyle(.newsRow)
                        
                        Rectangle()
                            .foregroundStyle(Color(#colorLiteral(red: 0.337254902, green: 0.1137254902, blue: 0.7490196078, alpha: 1)))
                            .frame(width: screenSize.width * scrollOffset)
                            .animation(.easeIn, value: scrollOffset)
                    }
                        .ignoresSafeArea(edges: .top)
                        .shadow(radius: 10)
                }
                    
                DynamicView(scrollOffset: $scrollOffset,
                            imageURL: news.image,
                            title: news.title,
                            author: news.author,
                            publishDate: news.publishDate)
                .padding(.top, 3)
                
                AdvancedScrollView(scrollOffset: $scrollOffset) {
                    ScrollView {
                        Text(news.text)
                            .padding()
                    }
                }
            }
            .fontDesign(.rounded)
            .tint(.orange)
            
            // MARK: - ALERT
            HStack {
                Text("Source was coppied")
                    .fontWeight(.medium)
                
                Image(systemName: isCoppied ? "checkmark.circle" : "x.circle")
                    .contentTransition(.symbolEffect(.replace))
                    .foregroundStyle(isCoppied ? .green : .red)
            }
            .frame(width: 200, height: 50)
            .background {
                VisualEffectView(style: .systemMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 10)
            }
            .offset(y: -100)
            .opacity(isCoppied ? 1.0 : 0.0)
            .frame(maxHeight: screenSize.height, alignment: .bottom)
            .onChange(of: isCoppied) { _, newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    withAnimation {
                        if newValue == true {
                            isCoppied = false
                        }
                    }
                }
            }
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
