//
//  SavedNewsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct SavedNewsView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @FetchRequest(fetchRequest: NewsEntity.fetchSaveNews(), animation: .easeInOut)
    var items: FetchedResults<NewsEntity>
    
    @State private var isActive = false
    @State private var togglingForm = false
    
    var body: some View {
        ZStack {
            Color
                .colorSet3
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Saved news")
                        .font(.largeTitle)
                        .padding([.top, .leading])
                    
                    Spacer()
                    
                    Button{
                        withAnimation {
                            togglingForm.toggle()
                        }
                    } label: {
                        Image(systemName: togglingForm ? "list.bullet.circle" : "square.grid.2x2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    }
                    .accentColor(.black)
                    .padding([.top, .trailing])
                }
                
                Divider()
                
                if togglingForm {
                    List(items) { item in
                        RowView(item: item, rowViewOrientation: .vertical)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                newsVM.selectedNews = item
                                isActive.toggle()
                            }
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .background {
                        NavigationLink(isActive: $isActive) {
                            NewsDetails(selectedNews: newsVM.selectedNews ?? NewsEntity())
                            .navigationBarBackButtonHidden(true)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0.0)
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: [ GridItem(.flexible()), GridItem(.flexible()) ], spacing: 10) {
                            ForEach(items, id: \.self) { item in
                                RowView(item: item, rowViewOrientation: .horizontal)
                                    .onTapGesture {
                                        newsVM.selectedNews = item
                                        isActive.toggle()
                                    }
                            }
                        }
                        .padding(.horizontal, 7)
                    }
                    .background {
                        NavigationLink(isActive: $isActive) {
                            NewsDetails(selectedNews: newsVM.selectedNews ?? NewsEntity())
                            .navigationBarBackButtonHidden(true)
                        } label: {
                           EmptyView()
                        }
                        .opacity(0.0)
                    }
                }
            }
        }
        .refreshable {
            
        }
    }
}

#Preview {
    SavedNewsView()
        .environmentObject(NewsViewModel())
        .environment(\.managedObjectContext,
                      CoreDataService.preview.previewContainer!.viewContext)
}
