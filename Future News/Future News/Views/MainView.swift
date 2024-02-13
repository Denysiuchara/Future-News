//
//  MainView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @State private var tabSelection = 1
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tabSelection) {
                Group {
                    HomeView()
                        .environmentObject(newsVM)
                        .tag(1)
                    
                    SavedNewsView()
                        .environmentObject(newsVM)
                        .tag(2)
                    
                    SettingsView()
                        .tag(3)
                }
                .toolbarBackground(.hidden, for: .tabBar)
            }
            .overlay(alignment: .bottom) {
                CustomTabView(tabSelection: $tabSelection)
            }
            .tint(.colorSet6)
        }
    }
}

#Preview {
    MainView()
        .environment(\.managedObjectContext, CoreDataService.preview.previewContainer!.viewContext)
        .environmentObject(NewsViewModel())
}
