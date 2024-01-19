//
//  VisualEffectView.swift
//  Future News
//
//  Created by Danya Denisiuk on 19.01.2024.
//

import SwiftUI

struct VisualEffectView: View {
    var style: UIBlurEffect.Style
    
    var body: some View {
        let blur = UIBlurEffect(style: style)
        return VisualEffectBlur(blur: blur)
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    let blur: UIBlurEffect

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: blur)
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = blur
    }
}

#Preview {
    VisualEffectView(style: .light)
}
