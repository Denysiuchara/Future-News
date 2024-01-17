//
//  TestingDynamicView.swift
//  Future News
//
//  Created by Danya Denisiuk on 17.01.2024.
//

import SwiftUI

struct TestingDynamicView: View {
    @Environment(\.screenSize) private var screenSize
    
    @State private var scrollOffset: CGFloat = 0.0 {
        willSet {
            print(scrollOffset)
        }
    }
    
    @State private var contentHeight: CGFloat = 300
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: "https://media.istockphoto.com/id/1311148884/vector/abstract-globe-background.jpg?s=612x612&w=0&k=20&c=9rVQfrUGNtR5Q0ygmuQ9jviVUfrnYHUHcfiwaH5-WFE=")) { image in
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
                
                Text("Some Text for Title")
                    .padding(.horizontal)
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Author")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal)
                    .frame(width: screenSize.width, alignment: .leading)
                
                Text("20.12.2023 17:51")
                    .font(.footnote)
                    .padding(.horizontal)
                    .frame(width: screenSize.width, alignment: .leading)
            }
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.newsRow)
            }
            .animation(.linear(duration: 1)) { content in
                            content
                                .frame(height: contentHeight)
                                .onChange(of: scrollOffset) { _, newValue in
                                    withAnimation {
                                        self.contentHeight = newValue > 0.0 && newValue <= 1.0 ? 150 : 300
                                    }
                                }
                        }
            
            Spacer()
            
            Button {
                if scrollOffset == 0.0 {
                    scrollOffset = 1.0
                } else if scrollOffset == 1.0 {
                    scrollOffset = 0.0
                }
            } label: {
                Text("Change value")
                    .foregroundStyle(.white)
            }
            .padding()
            .background {
               RoundedRectangle(cornerRadius: 20)
                    .fill(.red)
            }
        }
    }
}

#Preview {
    TestingDynamicView()
}
