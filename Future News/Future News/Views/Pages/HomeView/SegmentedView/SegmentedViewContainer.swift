//
//  ProgressAlert.swift
//  Future News
//
//  Created by Danya Denisiuk on 04.02.2024.
//

import SwiftUI

struct SegmentedViewContainer: View {
    @Environment(\.screenSize) private var screenSize
    @EnvironmentObject var newsVM: NewsViewModel
    @State var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            SegmentedView(selectedIndex: $selectedIndex,
                          titles: newsVM.titlesTopic)
                .zIndex(1)
                .onChange(of: selectedIndex) { oldValue, newValue in
                    if oldValue != newValue {
                        newsVM.fetchNews(titleNumber: selectedIndex)
                    }
                }
            
            ProgressAlert(isNewDataLoaded: $newsVM.isNewDataLoaded)
        }
    }
}

#Preview {
    SegmentedViewContainer()
        .environmentObject(NewsViewModel())
}
