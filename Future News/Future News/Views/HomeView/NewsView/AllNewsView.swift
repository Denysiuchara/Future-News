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
    @State private var selectedNews: NewsEntity?
    
    var body: some View {
        ZStack(alignment: .top) {
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
                
                ForEach(items) { element in
                    NewsCell(
                        isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                        isPresentedNewsDetails: $isPresentedNewsDetails,
                        news: element
                    )
                    .listRowBackground(Color.colorSet3)
                    .onLongPressGesture(minimumDuration: 0.3, maximumDistance: 15) {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 2)
                        withAnimation {
                            selectedNews = element
                            self.isPresentedPreviewNewsDetails = true
                        }
                    }
                }
            }
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
            .allowsHitTesting(!isPresentedPreviewNewsDetails)
            .blur(radius: isPresentedPreviewNewsDetails ? 10 : 0)
            .scrollIndicators(.hidden)
            
            if let news = selectedNews {
                PreviewNewsDetails(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                                   isPresentedNewsDetails: $isPresentedNewsDetails,
                                   news: news)
                .opacity(isPresentedPreviewNewsDetails ? 1.0 : 0.0)
                .onDisappear {
                    print("PreviewNewsDetails disappear")
                    selectedNews = nil
                }
            }
        }
    }
}

#Preview {
    AllNewsView(isPresentedPreviewNewsDetails: .constant(false))
    .environment(\.managedObjectContext, CoreDataService.preview.previewContainer!.viewContext)
}
