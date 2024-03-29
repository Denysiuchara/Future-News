//
//  ProgressAlertView.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.02.2024.
//

import SwiftUI

struct ProgressAlert: View {
    @Binding var isNewDataLoaded: Bool
    
    var body: some View {
        HStack {
            Text("News is loading. Please wait!")
                .foregroundStyle(.white)
                .font(.system(size: 15))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .padding(.trailing, 10)
            
            ZStack {
                ProgressView()
                    .tint(.white)
                
                ProgressView()
                    .tint(Color(#colorLiteral(red: 0.337254902,
                                              green: 0.1137254902,
                                              blue: 0.7490196078,
                                              alpha: 1)))
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .foregroundStyle(Color(.systemGray4))
                        .shadow(radius: 3)
                }
        }
        .animation(.linear) {
            $0
                .opacity(isNewDataLoaded ? 1.0 : 0.0)
                .frame(height: isNewDataLoaded ? 20 : 0)
                .offset(y: isNewDataLoaded ? 0 : -20)
        }
    }
}

#Preview {
    ProgressAlert(isNewDataLoaded: .constant(true))
}
