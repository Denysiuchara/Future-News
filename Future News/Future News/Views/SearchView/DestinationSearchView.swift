//
//  DestinationSearchView.swift
//  Future News
//
//  Created by Danya Denisiuk on 12.12.2023.
//

import SwiftUI

enum DestinationSearchOptions {
    case text
    case authors
    case dates
}

struct DestinationSearchView: View {
    @Binding var isShow: Bool
    
    @State private var destination = ""
    
    @State private var selectedOption: DestinationSearchOptions = .text
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.snappy) {
                    isShow.toggle()
                }
            } label: {
                Image(systemName: "xmark.circle")
                    .imageScale(.large)
                    .foregroundStyle(.black)
            }
            
            VStack(alignment: .leading) {
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
            }
            .padding()
            .background(.backround)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
            .onTapGesture {
                selectedOption = .text
            }
            
            // date selection
            CollapsedPickerView(title: "When", description: "Add dates")
                .onTapGesture {
                    selectedOption = .dates
                }
            
            
            CollapsedPickerView(title: "Who", description: "Add some information")
                .onTapGesture {
                    selectedOption = .authors
                }
        }
    }
}

#Preview {
    DestinationSearchView(isShow: .constant(false))
}


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
        .padding()
        .background(.backround)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
        .shadow(radius: 10)
    }
}
