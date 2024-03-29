//
//  SearchView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            VStack(alignment: .leading) {
                Text("What we looking for?")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                
                Text("Search for news")
                    .font(.caption2)
                    .fontDesign(.rounded)
            }
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
            }
        }
        .foregroundStyle(colorScheme == .dark ? .black : .white)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: .black.opacity(0.4), radius: 2)
        }
        .background {
            RoundedRectangle(cornerRadius: 14)
                .fill(.colorSet5)
                .opacity(colorScheme == .dark ? 1.0 : 0.6)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchView()
}
