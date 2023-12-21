//
//  PublisherButton.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.12.2023.
//

import SwiftUI

struct PublisherButton: View {
    @Binding var publisherData: PublisherData
    
    let action: () -> Void
    
    var body: some View {
        Button {
            publisherData.isTapped.toggle()

            if publisherData.isTapped {
                publisherData.randomColor = Color.random()
                action()
            } else {
                publisherData.randomColor = Color.white.opacity(0.1)
            }
        } label: {
            Text(publisherData.subject)
                .padding(10)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(publisherData.isTapped ? publisherData.randomColor : .black.opacity(0.2))
                }
                .fontWeight(.black)
                .fontDesign(.rounded)
        }
    }
}
