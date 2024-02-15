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
                    
                    Button {
                        withAnimation {
                            togglingForm.toggle()
                        }
                    } label: {
                        Image(systemName: togglingForm ? "list.bullet.circle" : "square.grid.2x2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    }
                    .opacity(!items.isEmpty ? 1.0 : 0.0)
                    .accentColor(.black)
                    .padding([.top, .trailing])
                }
                .padding(.bottom)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.colorSet3)
                        .shadow(radius: 5)
                        .ignoresSafeArea()
                }
                
                if items.isEmpty {
                    VStack {
                        Text("😕")
                            .font(.system(size: 80))
                        Text("You haven't saved any news...")
                            .font(.system(size: 23))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                
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
                        LazyVGrid(columns: [ GridItem(.flexible()),
                                             GridItem(.flexible()) ],
                                  spacing: 10) {
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
    }
}

#Preview {
    SavedNewsView()
        .environmentObject(NewsViewModel())
        .environment(\.managedObjectContext,
                      CoreDataService.preview.previewContainer!.viewContext)
}
