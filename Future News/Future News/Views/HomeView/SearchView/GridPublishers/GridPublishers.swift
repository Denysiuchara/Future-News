//
//  GridPublishers.swift
//  Future News
//
//  Created by Danya Denisiuk on 13.12.2023.
//

import SwiftUI
import WrappingHStack

struct PublisherData {
    let subject: String
    var isTapped: Bool
    var randomColor: Color
}

struct GridPublishers: View {
    @State private var publisherData: [PublisherData]
    
    let subjects = ["TSN.UA", "Wall Stree Journal", "BBC",
                    "RBC", "Censor", "The New York Times",
                    "Aljazeera", "CNN", "Washigton Post",
                    "CNBC", "ABC News"]
    
    init() {
        self._publisherData = State(initialValue: subjects.map {
                                        PublisherData(subject: $0,
                                                      isTapped: false,
                                                      randomColor: Color.white.opacity(0.1))
                                    })
    }
    
    var body: some View {
        WrappingHStack(alignment: .leading) {
            ForEach(publisherData.indices, id: \.self) { index in
                PublisherButton(publisherData: $publisherData[index]) {
                    print(subjects[index])
                }
            }
        }
    }
}

#Preview {
    GridPublishers()
}
