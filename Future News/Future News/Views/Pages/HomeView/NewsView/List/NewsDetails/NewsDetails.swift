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
    @State private var scrollOffset: CGFloat = 0
    @State private var isCoppied = false
    
    @ObservedObject var selectedNews: NewsEntity
    @State private var textHeight: Double = 0
    
    var body: some View {
        ZStack {
            
            Color(.colorSet3)
                .opacity(0.5)
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
                            selectedNews.toggle()
                            selectedNews.objectWillChange.send()
                        } label: {
                            Image(systemName: selectedNews.isSaveNews ? "bookmark.fill" : "bookmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(selectedNews.isSaveNews ? .orange : .black)
                                .frame(width: 30, height: 30)
                        }
                        .padding(.trailing, 5)
                        
                        //  MARK: - Call menu button
                        MenuView(isCoppied: $isCoppied, sourceURL: selectedNews.sourceURL_)
                    }
                    .foregroundStyle(.foreground)
                    .padding(.horizontal)
                }
                .padding(.bottom)
                .background {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundStyle(.colorSet3)
                        
                        Rectangle()
                            .foregroundStyle(Color(#colorLiteral(red: 0.337254902,
                                                                 green: 0.1137254902,
                                                                 blue: 0.7490196078,
                                                                 alpha: 1)))
                            .frame(width: screenSize.width * scrollOffset)
                            .animation(.easeIn, value: scrollOffset)
                    }
                    .ignoresSafeArea(edges: .top)
                    .shadow(radius: 10)
                }
                    
                DynamicView(scrollOffset: $scrollOffset,
                            textHeight: $textHeight,
                            imageURL: selectedNews.imageURL_,
                            title: selectedNews.title_,
                            author: selectedNews.author_,
                            publishDate: selectedNews.publishDate_.publishingDifference())
                .padding(.top, 3)
                
                AdvancedScrollView(scrollOffset: $scrollOffset) {
                    ScrollView {
                        Text(selectedNews.text_)
                            .padding(.horizontal)
                            .background {
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            textHeight = geometry.size.height
                                        }
                                }
                            }
                    }
                }
            }
            .fontDesign(.rounded)
            .tint(.orange)
            
            // MARK: - ALERT
            NewsDetailsAlert(isCoppied: $isCoppied)
        }
    }
}
