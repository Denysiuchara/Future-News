//
//  HeaderView.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var isNewDataLoaded: Bool
    @Binding var togglingForm: Bool
    @State var buttonOpacity: Double
    
    var isAppearProgressAlert: Bool = false
    
    var body: some View {
        HStack {
            Text("Saved news")
                .font(.largeTitle)
                .padding([.top, .leading])
            
            Spacer()
            
            Button {
                withAnimation {
                    togglingForm.toggle()
                }
            } label: {
                Image(systemName: togglingForm ? "list.bullet.circle" : "square.grid.2x2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
            }
            .opacity(buttonOpacity)
            .accentColor(.black)
            .padding([.top, .trailing])
            
            if isAppearProgressAlert {
                ProgressAlert(isNewDataLoaded: $isNewDataLoaded)
            }
        }
        .padding(.bottom)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.colorSet3)
                .shadow(radius: 5)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    HeaderView(isNewDataLoaded: .constant(true), togglingForm: .constant(true), buttonOpacity: 1.0)
}
