//
//  PageControl.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct TabPageControl: View {
    @Binding var currentPage: Int
    @State var numberOfPages: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { page in
                Circle()
                    .strokeBorder(.orange, lineWidth: 2)
                    .frame(width: 11, height: 11)
                    .background {
                        Circle()
                            .foregroundStyle(page == currentPage ? .clear : .orange)
                    }
            }
        }
    }
}

#Preview {
    TabPageControl(currentPage: Binding(projectedValue: .constant(1)), numberOfPages: 10)
}
