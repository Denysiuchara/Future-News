//
//  SearchViewSection.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct SearchViewSection: View {
    @Binding var selectedOption: DestinationSearchOptions
    @Binding var destination: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if selectedOption == .text {
                Text("What we looking for?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.small)
                    
                    TextField("Search destinations", text: $destination)
                        .fontDesign(.rounded)
                        .font(.subheadline)
                }
                .frame(height: 44)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color(.systemGray4))
                }
            } else {
                CollapsedPickerView(title: "What we looking for?", description: "Add destination")
            }
        }
        .modifier(CollapsibleDestinationViewModifier())
        .frame(height: selectedOption == .text ? 120 : 60)
        .onTapGesture {
            withAnimation(.snappy) {
                selectedOption = .text
            }
        }
    }
}

#Preview {
    SearchViewSection(selectedOption: .constant(.text), destination: .constant(""))
}
