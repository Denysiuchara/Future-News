//
//  PublisherButton.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.12.2023.
//

import SwiftUI

struct PublisherButton: View {
    @State var sourseName: String
    @State private var isTapped: Bool = false
    @State private var color: Color = Color.white.opacity(0.1)
    
    let action: () -> Void
    
    var body: some View {
        Button {
            isTapped.toggle()
            
            if isTapped {
                color = Color.random()
            } else {
                color = Color.white.opacity(0.1)
            }
            
            action()
            
        } label: {
            Text(sourseName)
                .padding(10)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(isTapped ? color : .black.opacity(0.2))
                }
                .fontWeight(.black)
                .fontDesign(.rounded)
        }
    }
}
