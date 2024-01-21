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
    
    var body: some View {
        TabView {
            HomeView(isAppearAlertView: $isAppearAlertView)
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            SavedNewsView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                }
        }
        .onAppear {
            isAppearAlertView = true
        }
        .tint(.orange)
    }
}


#Preview {
    MainView()
}
