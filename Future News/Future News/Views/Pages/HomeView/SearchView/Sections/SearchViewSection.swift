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
    @State private var isAppearResetButton = false
    
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
                        .onChange(of: destination) { _, _ in
                            if !destination.isEmpty {
                                withAnimation {
                                    isAppearResetButton = true
                                }
                            } else {
                                withAnimation {
                                    isAppearResetButton = false
                                }
                            }
                        }
                    
                        Button {
                            destination = ""
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .opacity(isAppearResetButton ? 1.0 : 0.0)
                        .foregroundStyle(.black)
                        .font(.subheadline)
                        .fontWeight(.semibold)
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
