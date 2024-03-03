//
//  NewsDetailsAlert.swift
//  Future News
//
//  Created by Danya Denisiuk on 02.03.2024.
//

import SwiftUI

struct NewsDetailsAlert: View {
    @Environment(\.screenSize) private var screenSize
    @Binding var isCoppied: Bool
    
    var body: some View {
        HStack {
            Text("Source was coppied")
                .fontWeight(.medium)
            
            Image(systemName: isCoppied ? "checkmark.circle" : "x.circle")
                .contentTransition(.symbolEffect(.replace))
                .foregroundStyle(isCoppied == true ? .green : .red)
        }
        .frame(width: 200, height: 50)
        .background {
            VisualEffectView(style: .systemMaterial, alpha: 1.0)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)
        }
        .offset(y: -100)
        .opacity(isCoppied ? 1.0 : 0.0)
        .frame(maxHeight: screenSize.height, alignment: .bottom)
        .onChange(of: isCoppied) { _, newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    if newValue == true {
                        isCoppied = false
                    }
                }
            }
        }
    }
}

#Preview {
    NewsDetailsAlert(isCoppied: .constant(true))
}
