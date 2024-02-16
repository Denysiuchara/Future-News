//
//  GridPublishers.swift
//  Future News
//
//  Created by Danya Denisiuk on 13.12.2023.
//

import SwiftUI
import WrappingHStack


// TODO: - продумать как передавать значение в selectedPublishers внутри замыкания PublisherButton, главное требование, чтобы значение можно было как добавить так и удалить

struct GridPublishers: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    @Binding var selectedPublishers: Set<String>
    
    var body: some View {
        WrappingHStack(alignment: .leading) {
            ForEach(newsVM.newsSources.indices, id: \.self) { index in
                PublisherButton(sourseName: newsVM.newsSources[index].name) {
                    selectedPublishers.toggle(value: newsVM.newsSources[index].source)
                }
            }
        }
    }
}

#Preview {
    GridPublishers(selectedPublishers: .constant([]))
        .environmentObject(NewsViewModel())
}
