//
//  AlertView.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.01.2024.
//

import SwiftUI

struct AlertView: View {
    @Binding var isAppearAlertView: Bool
    
    private let userMessage =
    """
    Dear, user!
    This application is created using a free API.
    
    🙏Please wait!🙏
    
    In the meantime, take a look at the dancing dragon.😊
    """
    
    var body: some View {
        if isAppearAlertView {
            withAnimation(.easeIn(duration: 10)) {
                VStack(spacing: 0) {
                    Text(userMessage)
                        .padding()
                        .padding(.bottom, 25)
                        .background {
                            GeometryReader { geo in
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.colorSet1)
                                    .opacity(0.95)
                            }
                        }
                        .padding([.horizontal, .top])
                        .shadow(radius: 10)
                    
                    Button {
                        withAnimation(.default) {
                            isAppearAlertView.toggle()
                        }
                    } label: {
                        Text("Okey")
                            .font(.system(size: 20))
                    }
                    .padding()
                    .frame(width: 200)
                    .background {
                        GeometryReader { geo in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.colorSet1)
                        }
                    }
                    .shadow(radius: 10)
                    .offset(y: -20)
                }
            }
            .zIndex(100.0)
            .opacity(isAppearAlertView ? 1.0 : 0.0)
        }
    }
}

#Preview {
    AlertView(isAppearAlertView: .constant(true))
}
