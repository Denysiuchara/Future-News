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
    @State private var dynamicSize: CGFloat = 28
    
    @Binding var isPresentedPreviewNewsDetails: Bool
    @Binding var isActive: Bool
    
    @State var news: NewsEntity
    
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
                            .frame(width: 30, height: 30)
                    }
                }
                
                Divider()
            }
            .padding([.horizontal, .top])
            .frame(width: screenSize.width, height: 45)
            
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
                    .frame(width: 370, alignment: .topLeading)
                
                VStack {
                    Divider()
                    
                    Text(news.text_)
                        .lineLimit(7)
                        .frame(height: isPresentedPreviewNewsDetails ? 200 : 0, alignment: .topLeading)
                        .padding(.horizontal)
                        .scaleEffect(CGSize(width: isPresentedPreviewNewsDetails ? 1 : 0,
                                            height: isPresentedPreviewNewsDetails ? 1 : 0),
                                     anchor: .topLeading)
                    
                    Button {
                        isActive.toggle()
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
                    .fill(.colorSet3)
                    .frame(width: geo.size.width, height: geo.size.height + 10)
                    .shadow(radius: 10)
            }
        }
        .opacity(isPresentedPreviewNewsDetails ? 1.0 : 0.0)
        .scaleEffect(CGSize(width: isPresentedPreviewNewsDetails ? 0.96 : 1,
                            height: isPresentedPreviewNewsDetails ? 0.96 : 1),
                     anchor: .center)
        .padding(.bottom)
    }
}
