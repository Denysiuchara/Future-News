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
  
                HeaderView(titleText: "Saved News",
                           isAppearDismissButton: false,
                           isNewDataLoaded: $newsVM.isNewDataLoaded,
                           togglingForm: $togglingForm,
                           buttonOpacity: !items.isEmpty ? 1.0 : 0.0)
                
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
                    TableStyleView(items: _items, isActive: $isActive)
                        .environmentObject(newsVM)
                } else {
                    CollectionStyleView(items: _items, isActive: $isActive)
                        .environmentObject(newsVM)
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
