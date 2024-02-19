//
//  HeaderView.swift
//  Future News
//
//  Created by Danya Denisiuk on 16.02.2024.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.dismiss) private var dismiss
    
    var text: String
    var isAppearDismissButton: Bool
    @Binding var isNewDataLoaded: Bool
    @Binding var togglingForm: Bool
    @State var buttonOpacity: Double
    
    var isAppearProgressAlert: Bool = false
    
    var body: some View {
        VStack {
            if isAppearDismissButton {
                HStack {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
            }
            
            HStack {
                Text(text)
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
    HeaderView(text: "SomeText",
               isAppearDismissButton: true,
               isNewDataLoaded: .constant(true),
               togglingForm: .constant(true),
               buttonOpacity: 1.0)
}
