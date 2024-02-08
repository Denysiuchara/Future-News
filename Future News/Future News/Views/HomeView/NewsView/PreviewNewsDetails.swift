//
//  PreviewNewsDetails.swift
//  Future News
//
//  Created by Danya Denisiuk on 21.01.2024.
//

import SwiftUI
import CoreData

struct PreviewNewsDetails: View {
    @Environment(\.screenSize) private var screenSize
    @Environment(\.dismiss) private var dismiss
    
    @State private var dynamicSize: CGFloat = 28
    
    @State var news: NewsEntity
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.black)
                            .frame(width: 30, height: 30)
                    }
                }
                
                Divider()
            }
            .padding([.horizontal])
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(news.title_)
                        .font(.system(size: 23))
                        .lineLimit(2)
                        .fontWeight(.bold)
                        .padding(.top, 6)
                    
                    Text(String(describing: news.publishDate_))
                        .fontDesign(.rounded)
                        .frame(width: screenSize.width * 0.50, height: 20, alignment: .leading)
                        .opacity(0.5)
                        .font(.system(size: 13))
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            VStack {
                AsyncImage(url: news.imageURL_) { image in
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
                
                Text(news.author_)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                
                VStack {
                    Divider()
                    
                    Text(news.text_)
                        .lineLimit(9)
                        .frame(height: 200, alignment: .topLeading)
                        .padding(.horizontal)
                }
            }
        }
    }
}
