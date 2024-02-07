//
//  AllNewsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct AllNewsView: View {
    @Environment(\.screenSize) private var screenSize
    
    @ObservedObject private var newsVM = NewsViewModel()
    
    @FetchRequest(fetchRequest: NewsEntity.fetch(), animation: .easeInOut)
    private var items: FetchedResults<NewsEntity>
    
    @Binding var isPresentedPreviewNewsDetails: Bool
    
    @State private var isPresentedNewsDetails = false
    
    @State private var isActive = false
    
    var body: some View {
        ZStack(alignment: .top) {
            NavigationView {
            List {
                TabCard()
                    .listRowBackground(Color.colorSet3)
                    .frame(width: screenSize.width,
                           height: screenSize.height * 0.3)
                
                HStack {
                    Text("Latest news")
                        .fontDesign(.rounded)
                        .font(.title)
                        .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .listRowBackground(Color.colorSet3)
                
                ForEach(items, id: \.self) { element in
                    
                    NavigationLink(isActive: $isActive) {
                        NewsDetails(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                                    selectedNews: newsVM.selectedNews ?? NewsEntity())
                        .navigationBarBackButtonHidden(true)
                        .id(element.id_)
                    } label: {
                        NewsCell(selectedNews: element)
                        .id(element.id_)
                    }
                    .onTapGesture {
                        newsVM.selectedNews = element
                        isActive.toggle()
                    }
                    .onLongPressGesture(minimumDuration: 0.3, maximumDistance: 15) {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 2)
                        withAnimation {
                            newsVM.selectedNews = element
                            self.isPresentedPreviewNewsDetails = true
                        }
                    }
                    
//                    NewsCell(
//                        isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
//                        isPresentedNewsDetails: $isPresentedNewsDetails,
//                        selectedNews: element)
//                    .listRowBackground(Color.colorSet3)
//                    .onLongPressGesture(minimumDuration: 0.3, maximumDistance: 15) {
//                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 2)
//                        withAnimation {
//                            selectedNews = element
//                            self.isPresentedPreviewNewsDetails = true
//                        }
//                    }
                }
            }
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
            .allowsHitTesting(!isPresentedPreviewNewsDetails)
            .blur(radius: isPresentedPreviewNewsDetails ? 10 : 0)
            .scrollIndicators(.hidden)
        }
            
            if let news = newsVM.selectedNews {
                PreviewNewsDetails(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                                   isActive: $isActive,
                                   news: news)
                .opacity(isPresentedPreviewNewsDetails ? 1.0 : 0.0)
                .onChange(of: isPresentedPreviewNewsDetails) { _, newValue in
                    if newValue == false { newsVM.selectedNews = nil }
                }
            }
        }
    }
}

#Preview {
    AllNewsView(isPresentedPreviewNewsDetails: .constant(false))
    .environment(\.managedObjectContext, CoreDataService.preview.previewContainer!.viewContext)
}
