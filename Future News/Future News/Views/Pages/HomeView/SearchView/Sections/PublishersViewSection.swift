//
//  PublishersViewSection.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct NewsSourcesViewSection: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @Binding var selectedOption: DestinationSearchOptions
    @Binding var selectedPublishers: Set<String>
    
    var body: some View {
        VStack(alignment: .leading) {
            if selectedOption == .sources {
                Text("Selecting publisher's")
                    .padding(.top)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                GridPublishers(selectedPublishers: $selectedPublishers)
                    .environmentObject(newsVM)
            } else {
                CollapsedPickerView(title: "Who", description: "News Sources")
            }
        }
        .modifier(CollapsibleDestinationViewModifier())
        .frame(height: selectedOption == .sources ? 380 : 60)
        .onTapGesture {
            withAnimation(.snappy) {
                selectedOption = .sources
            }
        }
    }
}

#Preview {
    NewsSourcesViewSection(selectedOption: .constant(.sources),
                           selectedPublishers: .constant([]))
    .environmentObject(NewsViewModel())
}
