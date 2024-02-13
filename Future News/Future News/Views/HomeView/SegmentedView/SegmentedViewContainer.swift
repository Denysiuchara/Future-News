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
    @Binding var selectedIndex: Int
    
    let titles: [String] = ["All News",
                            "Business",
                            "Politics",
                            "Tech",
                            "Science",
                            "Games",
                            "Sport"
                           ]
    
    var body: some View {
        VStack {
            SegmentedView(selectedIndex: $selectedIndex, titles: titles)
                .zIndex(1)
                .onChange(of: selectedIndex) { _, newValue in
                    //                    newsVM.fetchNews(theme: )
                }
            
            ProgressAlertView(isNewDataLoaded: $newsVM.isNewDataLoaded)
        }
    }
}

struct ProgressAlertView: View {
    @Binding var isNewDataLoaded: Bool
    
    var body: some View {
        HStack {
            Text("News is loading. Please wait!")
                .foregroundStyle(.white)
                .font(.system(size: 15))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.trailing, 10)
            
            ProgressView()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame(width: 300, height: 25, alignment: .bottom)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .foregroundStyle(Color(.systemGray4))
                        .shadow(radius: 3)
                }
        }
        .animation(.linear) {
            $0
                .opacity(isNewDataLoaded ? 1.0 : 0.0)
                .frame(height: isNewDataLoaded ? 20 : 0)
                .offset(y: isNewDataLoaded ? 0 : -20)
        }
    }
}

#Preview {
    SegmentedViewContainer(selectedIndex: .constant(0))
}
