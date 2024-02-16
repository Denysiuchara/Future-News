//
//  DynamicView.swift
//  Future News
//
//  Created by Danya Denisiuk on 17.01.2024.
//

import SwiftUI

struct DynamicView: View {
    @Environment(\.screenSize) private var screenSize
    
    @Binding var scrollOffset: CGFloat
    
    let imageURL: URL
    let title: String
    let author: String?
    let publishDate: String
    
    @State private var contentHeight: CGFloat = 0
    
    init(scrollOffset: Binding<CGFloat>,
         imageURL: URL,
         title: String,
         author: String?,
         publishDate: String) {
        self._scrollOffset = scrollOffset
        self.imageURL = imageURL
        self.title = title
        self.author = author
        self.publishDate = publishDate
        self._contentHeight = State(initialValue: screenSize.height * 0.45)
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .animation(.easeInOut) { content in
                        content
                            .scaleEffect(isScrollOffsetChanging() ? 0 : 1, anchor: .bottom)
                            .frame(width: isScrollOffsetChanging() ? 0 : screenSize.width * 0.96,
                                   height: isScrollOffsetChanging() ? 0 : screenSize.height * 0.30)
                    }
                    .clipped()
                    
            } placeholder: {
                Image("news_blank_image")
                    .resizable()
                    .scaledToFill()
                    .animation(.easeInOut) { content in
                        content
                            .scaleEffect(isScrollOffsetChanging() ? 0 : 1, anchor: .bottom)
                            .frame(width: isScrollOffsetChanging() ? 0 : screenSize.width * 0.96,
                                   height: isScrollOffsetChanging() ? 0 : screenSize.height * 0.30)
                    }
                    .clipped()
            }
            .opacity(isScrollOffsetChanging() ? 0.0 : 1)
            
            Text(title)
                .lineLimit(isScrollOffsetChanging() ? 1 : 3)
                .minimumScaleFactor(0.9)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
                .frame(width: screenSize.width, alignment: .leading)
            
            Text(author ?? "Unknown author")
                .minimumScaleFactor(0.9)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal)
                .frame(width: screenSize.width, alignment: .leading)
            
            Text(publishDate)
                .minimumScaleFactor(0.9)
                .font(.footnote)
                .padding(.horizontal)
                .frame(width: screenSize.width, alignment: .leading)
        }
        .animation(.default) { content in
            content
                .frame(height: contentHeight)
                .onChange(of: scrollOffset) { _, newValue in
                    withAnimation {
                        self.contentHeight = isScrollOffsetChanging() ? (screenSize.height * 0.10) : (screenSize.height * 0.45)
                    }
                }
                .background {
                    GeometryReader { contentGeo in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.colorSet3)
                            .shadow(radius: 5)
                    }
                }
        }
    }
    
    private func isScrollOffsetChanging() -> Bool {
        scrollOffset >= 0.05 && scrollOffset <= 1
    }
}

#Preview {
    Group {
        DynamicView(scrollOffset: .constant(0.0),
                    imageURL: URL(string:  "https://media.istockphoto.com/id/1311148884/vector/abstract-globe-background.jpg?s=612x612&w=0&k=20&c=9rVQfrUGNtR5Q0ygmuQ9jviVUfrnYHUHcfiwaH5-WFE=")!,
                    title: "Some Text for Title",
                    author: "Author",
                    publishDate: "1 minute ago")
        
        DynamicView(scrollOffset: .constant(0.05),
                    imageURL: URL(string:  "https://media.istockphoto.com/id/1311148884/vector/abstract-globe-background.jpg?s=612x612&w=0&k=20&c=9rVQfrUGNtR5Q0ygmuQ9jviVUfrnYHUHcfiwaH5-WFE=")!,
                    title: "Some Text for Title",
                    author: "Author",
                    publishDate: "1 minute ago")
    }
}
