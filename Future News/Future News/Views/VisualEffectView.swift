//
//  VisualEffectView.swift
//  Future News
//
//  Created by Danya Denisiuk on 19.01.2024.
//

import SwiftUI

struct VisualEffectView: View {
    var style: UIBlurEffect.Style
    var alpha: CGFloat
    
    var body: some View {
        let blur = UIBlurEffect(style: style)
        return VisualEffectBlur(blur: blur, alpha: alpha)
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    let blur: UIBlurEffect
    let alpha: CGFloat

    func makeUIView(context: Context) -> UIVisualEffectView {
        var blurEffectView =  UIVisualEffectView(effect: blur)
            blurEffectView.alpha = alpha
        
        return blurEffectView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = blur
        uiView.alpha = alpha
    }
}

#Preview {
    VisualEffectView(style: .systemUltraThinMaterial, alpha: 0.7)
}
