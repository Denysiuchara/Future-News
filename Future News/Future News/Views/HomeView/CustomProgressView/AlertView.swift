//
//  AlertView.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.01.2024.
//

import SwiftUI

struct AlertView: View {
    @Binding var isAppear: Bool
    
    private let userMessage =
    """
    Dear, user!
    This application is created using a free API.
    
    🙏Please wait!🙏
    
    In the meantime, take a look at the dancing dragon.😊
    """
    
    var body: some View {
        if isAppear {
            withAnimation(.easeIn(duration: 10)) {
                VStack(spacing: 0) {
                    Text(userMessage)
                        .padding()
                        .padding(.bottom, 25)
                        .background {
                            GeometryReader { geo in
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.newsRow)
                            }
                        }
                        .padding([.horizontal, .top])
                        .shadow(radius: 10)
                    
                    Button {
                        withAnimation(.default) {
                            isAppear.toggle()
                        }
                    } label: {
                        Text("Okey")
                            .foregroundStyle(.black)
                            .font(.system(size: 20))
                    }
                    .padding()
                    .frame(width: 200)
                    .background {
                        GeometryReader { geo in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.newsRow)
                        }
                    }
                    .shadow(radius: 10)
                    .offset(y: -20)
                }
            }
            .zIndex(100.0)
            .opacity(isAppear ? 1.0 : 0.0)
        }
    }
}

#Preview {
    AlertView(isAppear: .constant(true))
}
