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
    @Binding var isPresentedNewsDetails: Bool
    @Binding var isAppearAlertView: Bool
    
    @State private var selectedNews: NewsEntity?
    
    var body: some View {
        ZStack(alignment: .top){
            List {
                // TODO: - Add more information in CardView, and add destination to tap
                TabCard()
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
                
                ForEach(items) { element in
                    NewsCell(
                        isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                        isPresentedNewsDetails: $isPresentedNewsDetails,
                        news: element
                    )
                    .onLongPressGesture(minimumDuration: 0.3, maximumDistance: 15) {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 2)
                        withAnimation {
                            selectedNews = element
                            self.isPresentedPreviewNewsDetails = true
                        }
                    }
                }
                .listRowBackground(Color.colorSet3)
            }
            .listStyle(.inset)
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
    AllNewsView(isPresentedPreviewNewsDetails: .constant(false),
                isPresentedNewsDetails: .constant(false),
                isAppearAlertView: .constant(false))
    .environment(\.managedObjectContext, CoreDataService.preview.previewContainer!.viewContext)
}
