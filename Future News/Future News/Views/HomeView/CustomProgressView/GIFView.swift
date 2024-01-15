//
//  GIFView.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.01.2024.
//

import SwiftUI
import FLAnimatedImage

struct GIFView: UIViewRepresentable {
    
    var fileName: String
    var path: String?
    
    init(fileName: String) {
        self.fileName = fileName
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "gif") {
            self.path = path
        } else {
            self.path = nil
        }
    }
    
    private let animatedView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.masksToBounds = true
        return imageView
      }()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        guard let path = path else { return view }
        
        let url = URL(filePath: path)
        let gifData = try! Data(contentsOf: url)
        let gif = FLAnimatedImage(animatedGIFData: gifData)
        
        animatedView.animatedImage = gif
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animatedView)
        
        animatedView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animatedView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let path = path else {
            print("\(#function) invalid path")
            return
        }
        
        let url = URL(filePath: path)
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = FLAnimatedImage(animatedGIFData: data)
                
                DispatchQueue.main.async {
                    animatedView.animatedImage = image
                }
            }
        }
    }
}

#Preview {
    GIFView(fileName: "dragon")
}
