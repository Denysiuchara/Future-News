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
    
    @State private var isActive = false
    
    var body: some View {
        ZStack(alignment: .top) {
            List {
                TabCard()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.colorSet3)
                    .frame(width: screenSize.width,
                           height: screenSize.height * 0.3)
                
                HStack {
                    Text("Latest news")
                        .fontDesign(.rounded)
                        .font(.title)
                    
                    Spacer()
                }
                .listRowBackground(Color.colorSet3)
                
                ForEach(items, id: \.self) { element in
                    
                    ZStack {
                        NewsCell(selectedNews: element)
                        //FIXME: - Incorrected data
                            .sheet(isPresented: $isPresentedPreviewNewsDetails) {
                                PreviewNewsDetails(news: element)
                                    .presentationBackground(.colorSet3)
                                    .presentationDetents([.height(650)])
                            }
                            .onTapGesture {
                                newsVM.selectedNews = element
                                isActive.toggle()
                            }
                            .onLongPressGesture(minimumDuration: 0.3, maximumDistance: 15) {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 2)
                                newsVM.selectedNews = element
                                self.isPresentedPreviewNewsDetails = true
                            }
                            .id(element.id_)
                        
                        NavigationLink(isActive: $isActive) {
                            NewsDetails(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                                        selectedNews: newsVM.selectedNews ?? NewsEntity())
                            .navigationBarBackButtonHidden(true)
                            .id(element.id_)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0.0)
                    }
                    .listRowBackground(Color.colorSet3)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.inset)
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    AllNewsView(isPresentedPreviewNewsDetails: .constant(true))
        .environment(\.managedObjectContext,
                      CoreDataService.preview.previewContainer!.viewContext)
}
