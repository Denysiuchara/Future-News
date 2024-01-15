//
//  MainView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct MainView: View {
    @State private var isAppear = false
    
    var body: some View {
        TabView {
            HomeView(isAppear: $isAppear)
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
            isAppear = true
        }
        .tint(.orange)
    }
}


#Preview {
    MainView()
}
