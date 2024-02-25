//
//  HeaderView.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct HeaderView: View {
    
    var titleText: String
    var isAppearDismissButton: Bool
    @Binding var isNewDataLoaded: Bool
    @Binding var togglingForm: Bool
    @State var buttonOpacity: Double
    
    var isAppearProgressAlert: Bool = false
    
    var action: () -> () = {}
    
    var body: some View {
        VStack {
            if isAppearDismissButton {
                HStack {
                    Button {
                        withAnimation {
                            action()
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
            }
            
            HStack {
                Text(titleText)
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
            }
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.colorSet3)
            }

            
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
    HeaderView(titleText: "SomeText",
               isAppearDismissButton: true,
               isNewDataLoaded: .constant(true),
               togglingForm: .constant(true),
               buttonOpacity: 1.0, action: { })
}
