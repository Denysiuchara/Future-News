//
//  MainView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var isPresentedPreviewNewsDetails = false
    @State private var tabSelection = 1
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tabSelection) {
                Group {
                    HomeView(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails)
                        .tag(1)
                    
                    SavedNewsView()
                        .tag(2)
                    
                    SettingsView()
                        .tag(3)
                }
                .toolbarBackground(.hidden, for: .tabBar)
            }
            .overlay(alignment: .bottom) {
                CustomTabView(tabSelection: $tabSelection)
                    .blur(radius: isPresentedPreviewNewsDetails ? 10 : 0)
                    .offset(y: isPresentedPreviewNewsDetails ? 200 : 0)
            }
            .tint(.colorSet6)
        }
    }
}

#Preview {
    MainView()
        .environment(\.managedObjectContext, CoreDataService.preview.previewContainer!.viewContext)
}
