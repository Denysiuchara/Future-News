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
    
    @Binding var isPresentedPreviewNewsDetails: Bool
    
    @State private var scrollOffset: CGFloat = 0
    @State private var isCoppied = false
    
    @ObservedObject var selectedNews: NewsEntity
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                VStack {
                    HStack {
                        Button {
                            isPresentedPreviewNewsDetails = false
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
                            .foregroundStyle(Color(#colorLiteral(red: 0.337254902, green: 0.1137254902, blue: 0.7490196078, alpha: 1)))
                            .frame(width: screenSize.width * scrollOffset)
                            .animation(.easeIn, value: scrollOffset)
                    }
                        .ignoresSafeArea(edges: .top)
                        .shadow(radius: 10)
                }
                    
                DynamicView(scrollOffset: $scrollOffset,
                            imageURL: selectedNews.imageURL_,
                            title: selectedNews.title_,
                            author: selectedNews.author_,
                            publishDate: selectedNews.publishDate_)
                .padding(.top, 3)
                
                AdvancedScrollView(scrollOffset: $scrollOffset) {
                    ScrollView {
                        Text(selectedNews.text_)
                            .padding(.horizontal)
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
                VisualEffectView(style: .systemMaterial, alpha: 1.0)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 10)
            }
            .offset(y: -100)
            .opacity(isCoppied ? 1.0 : 0.0)
            .frame(maxHeight: screenSize.height, alignment: .bottom)
            .onChange(of: isCoppied) { _, newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
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

//#Preview {
//    NewsDetails(isPresentedPreviewNewsDetails: .constant(false), selectedNews: .constant(NewsEntity()))
//}
