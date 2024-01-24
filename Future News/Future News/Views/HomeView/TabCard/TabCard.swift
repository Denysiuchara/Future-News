//
//  TabCard.swift
//  Future News
//
//  Created by Danya Denisiuk on 09.12.2023.
//

import SwiftUI

struct TabCard: View {
    
    // TODO: - Create binding with SaveNews
    private let imagePath = [
        "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
        "https://nystudio107.com/img/blog/_1200x675_crop_center-center_82_line/image_optimzation.jpg",
        "https://cc-prod.scene7.com/is/image/CCProdAuthor/d-03-4?$pjpeg$&jpegSize=200&wid=720",
        "https://t4.ftcdn.net/jpg/03/96/00/75/360_F_396007562_FPXMDvZROZp0Cnnn4hLX2Zs5zBPyQTFV.jpg",
    ]
    
    
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentPage) {
                ForEach(imagePath.indices, id: \.self) { index in
                    CardView(asyncImageName: imagePath[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                
                TabPageControl(numberOfPages: imagePath.count, currentPage: $currentPage)
                    .padding()
            }
        }
    }
}

#Preview {
    TabCard()
        .frame(height: 300)
}
