//
//  MainView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct MainView: View {
    /// Свойство для появление алерта
    @State private var isAppearAlertView = false
    @State private var isAppearDestinationSearchView = false
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            Group {
                HomeView(isAppearAlertView: $isAppearAlertView, isAppearDestinationSearchView: $isAppearDestinationSearchView)
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
                .offset(y: isAppearDestinationSearchView ? 200 : 0)
        }
        .onAppear {
            isAppearAlertView = true
        }
        .tint(.colorSet6)
    }
}

#Preview {
    MainView()
}
