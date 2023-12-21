//
//  SearchView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct SearchView: View {
    
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
                    .foregroundStyle(.gray)
                    .fontDesign(.rounded)
            }
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .overlay {
            Capsule()
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: .black.opacity(0.4), radius: 2)
        }
        .background {
            Capsule()
                .fill(.backround)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchView()
}
