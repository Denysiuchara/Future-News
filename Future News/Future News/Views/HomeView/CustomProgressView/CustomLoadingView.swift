//
//  CustomLoadView.swift
//  Future News
//
//  Created by Danya Denisiuk on 14.01.2024.
//

import SwiftUI

struct CustomLoadingView: View {

    var cornerRadius: CGFloat
    var lineWidth: CGFloat
    var duration: Double
    
    private let colors = [Color(#colorLiteral(red: 0.9843137255, green: 0.9176470588, blue: 0.6470588235, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.3333333333, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.4156862745, green: 0.7098039216, blue: 0.9294117647, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.1137254902, blue: 0.7490196078, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.9215686275, blue: 0.8509803922, alpha: 1))]
    
    @State private var rotation: Double = 0.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .trim(from: rotation - 0.3, to: rotation)
            .stroke(style: StrokeStyle(lineWidth: 10,
                                       lineCap: .round,
                                       lineJoin: .round))
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: colors), startPoint: UnitPoint(x: 0, y: -2), endPoint: UnitPoint(x: 4, y: 0)))
            .onAppear {
                withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: false)) {
                    self.rotation = 1.3
                }
            }
    }
}


#Preview {
    CustomLoadingView(cornerRadius: 20, lineWidth: 5, duration: 3.0)
}
