//
//  CollapsedPickerView.swift
//  Future News
//
//  Created by Danya Denisiuk on 13.12.2023.
//

import SwiftUI

struct CollapsedPickerView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text(description)
            }
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .font(.subheadline)
        }
    }
}


#Preview {
    CollapsedPickerView(title: "Text", description: "Another Text")
}
