//
//  ProgressAlert.swift
//  Future News
//
//  Created by Danya Denisiuk on 04.02.2024.
//

import SwiftUI

struct ProgressAlert: View {
    @Environment(\.screenSize) private var screenSize
    
    var body: some View {
        HStack {
            Text("New Material is loading. Please wait!")
                .foregroundStyle(.white)
                .font(.system(size: 15))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.trailing, 10)
            
            ProgressView()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame(width: 300, height: 25, alignment: .bottom)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .foregroundStyle(Color(.systemGray4))
                        .shadow(radius: 3)
                }
        }
        .offset(x: isLoading ? 0 : -(screenSize.height))
        .animation(.smooth(duration: 1), value: isLoading)
        .animation(.linear) { $0.opacity(isLoading ? 1 : 0) }
        .onAppear {
            isLoading = true
        }
    }
}

#Preview {
    ProgressAlert()
}
