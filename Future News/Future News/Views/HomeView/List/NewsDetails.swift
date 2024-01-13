//
//  NewsDetails.swift
//  Future News
//
//  Created by Danya Denisiuk on 20.12.2023.
//

import SwiftUI

struct NewsDetails: View {
    @State private var isCoppied = false
    @Environment(\.dismiss) var dismiss
    @Binding var isSafe: Bool
    var news: News
    
    var body: some View {
        ZStack {
            
            Color.backround
            
            VStack(alignment: .leading) {
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    
                    
                    // TODO: - Realize "share"
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.horizontal)
                
                AsyncImage(url: URL(string: news.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    Image("news_blank_image")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .frame(maxWidth: .infinity)
                
                ScrollView {
                    
                    HStack {
                        Spacer()
                        
                        Button{
                            isSafe.toggle()
                        } label: {
                            Image(systemName: isSafe ? "bookmark" : "bookmark.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .padding(.horizontal)
                    }
                    
                    Text(news.title)
                        .padding(.horizontal)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    HStack {
                        Text("Author: \(news.author ?? "Unknown author")")
                            .font(.subheadline)
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    Divider()
                    
                    HStack {
                        Text("Publishing date: \(news.publishDate)")
                            .font(.subheadline)
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    Text(news.text)
                        .padding()
                    
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
                        .padding(.horizontal)
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
                                                    text: "В Днепропетровской области днем 20 декабря Воздушные силы уничтожили российскую управляемую авиационную ракету.В Днепровском районе Днепропетровской области подразделением Воздушное командование Восток уничтожено управляемую авиационную ракету Х-59 Что этому предшествовало: Днем 20 декабря Воздушные силы сообщили о масштабной воздушной тревоге из-за угрозы применения Россией баллистического вооружения.",
                                                    url: "https://www.facebook.com/pvkshid/posts/pfbid02QU2pc58hJowb1HBAXFUUNDSdL5oKVLxui6guLgRhSzVPgMzpxcXrLsvPhDWTpiqwl",
                                                    image: "https://media.istockphoto.com/id/1311148884/vector/abstract-globe-background.jpg?s=612x612&w=0&k=20&c=9rVQfrUGNtR5Q0ygmuQ9jviVUfrnYHUHcfiwaH5-WFE=",
                                                    publishDate: "20.12.2023 17:51",
                                                    language: "uk",
                                                    sourceCountry: "Ukraine",
                                                    sentiment: 0.4,
                                                    author: "АЛЕКСАНДР ШУМИЛИН"))
}
