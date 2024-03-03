//
//  DynamicView.swift
//  Future News
//
//  Created by Danya Denisiuk on 17.01.2024.
//

import SwiftUI

struct DynamicView: View {
    @Environment(\.screenSize) private var screenSize
    @State private var contentHeight: CGFloat = 0
    
    @Binding var scrollOffset: CGFloat
    @Binding var textHeight: Double
    
    let imageURL: URL
    let title: String
    let author: String?
    let publishDate: String
    
    init(scrollOffset: Binding<CGFloat>,
         textHeight: Binding<Double>,
         imageURL: URL,
         title: String,
         author: String?,
         publishDate: String) {
        self._scrollOffset = scrollOffset
        self._textHeight = textHeight
        self.imageURL = imageURL
        self.title = title
        self.author = author
        self.publishDate = publishDate
    }
    
    var body: some View {
        VStack {
            
            Text(publishDate)
                .minimumScaleFactor(0.9)
                .font(.system(size: 15))
                .padding(.horizontal)
                .padding(.top)
                .frame(width: screenSize.width, alignment: .leading)
            
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .animation(.easeInOut) { content in
                        content
                            .scaleEffect(isScrollOffsetChanging() ? 0 : 1, anchor: .bottom)
                            .frame(width: isScrollOffsetChanging() ? 0 : screenSize.width * 0.96,
                                   height: isScrollOffsetChanging() ? 0 : screenSize.height * 0.30)
                    }
                    
            } placeholder: {
                Image("news-placeholder")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .animation(.easeInOut) { content in
                        content
                            .scaleEffect(isScrollOffsetChanging() ? 0 : 1, anchor: .bottom)
                            .frame(width: isScrollOffsetChanging() ? 0 : screenSize.width * 0.96,
                                   height: isScrollOffsetChanging() ? 0 : screenSize.height * 0.30)
                    }
            }
            .opacity(isScrollOffsetChanging() ? 0.0 : 1)
            
            Text(title)
                .lineLimit(isScrollOffsetChanging() ? 1 : 3)
                .minimumScaleFactor(0.9)
                .font(.system(size: 19))
                .fontWeight(.heavy)
                .padding(.horizontal)
                .frame(width: screenSize.width, alignment: .leading)
            
            Text(author ?? NSLocalizedString("Unknown author", comment: ""))
                .minimumScaleFactor(0.9)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.bottom)
                .frame(width: screenSize.width, alignment: .leading)
        }
        .onAppear {
            contentHeight = screenSize.height * 0.45
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
    
    /// Method which is responsible for making the DynamicView rollup animation correct
    private func isScrollOffsetChanging() -> Bool {
        let condition1 = textHeight >= screenSize.height * 2.0
        let condition2 = scrollOffset >= 0.05 && scrollOffset <= 1
        
        return withAnimation { condition1 && condition2 }
    }
}


#Preview {
    ScrollView {
        DynamicView(scrollOffset: .constant(0.07),
                    textHeight: .constant(300),
                    imageURL: URL(string:  "https://media.istockphoto.com/id/1311148884/vector/abstract-globe-background.jpg?s=612x612&w=0&k=20&c=9rVQfrUGNtR5Q0ygmuQ9jviVUfrnYHUHcfiwaH5-WFE=")!,
                    title: "Some Text for TitleSome Text for TitleSome Text for TitleSome Text for TitleSome Text for Title",
                    author: "Author",
                    publishDate: "1 minute ago")
        
        DynamicView(scrollOffset: .constant(0.05),
                    textHeight: .constant(300),
                    imageURL: URL(string:  "https://media.istockphoto.com/id/1311148884/vector/abstract-globe-background.jpg?s=612x612&w=0&k=20&c=9rVQfrUGNtR5Q0ygmuQ9jviVUfrnYHUHcfiwaH5-WFE=")!,
                    title: "Some Text for Title",
                    author: "Author",
                    publishDate: "1 minute ago")
    }
}
