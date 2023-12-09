//
//  PageControl.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct TabPageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 8){
            ForEach(0..<numberOfPages) { page in
                Circle()
                    .strokeBorder(.orange, lineWidth: 2)
                    .background(Circle())
                    .foregroundStyle(page == currentPage ? .clear : .orange)
                    .frame(width: 11, height: 11)
            }
        }
    }
}

#Preview {
    TabPageControl(numberOfPages: 10, currentPage: Binding(projectedValue: .constant(1)))
}
