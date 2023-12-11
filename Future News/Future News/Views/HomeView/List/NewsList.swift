//
//  NewsList.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct NewsList: View {
    @Binding var isSafe: Bool
    
    @State private var dynamicSize: CGFloat = 20
    
    var imagePath: [String]
    
    var body: some View {
        
        // FIXME: - Пераработать макет размеров, чтобы он подганялся под разный размер девайсов
        ForEach(imagePath.indices) { index in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.newsRow)
                    .opacity(0.5)
                    .frame(width: 300, height: 120)
                    .padding([.top], 20)
                    .padding([.leading], 50)
                    .padding([.trailing], 8)
                    .shadow(radius: 10)
                
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: imagePath[index])) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 10)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.gray)
                                .frame(width: 100, height: 100)
                        }
                        
                        Text("**Some text for testing**")
                            .lineLimit(2)
                            .frame(width: 200, height: 50, alignment: .topLeading)
                    }
                    HStack {
                        Spacer()
                        
                        Text("1 hour ago")
                            .frame(width: 100, height: 20, alignment: .leading)
                            .padding(.horizontal)
                            .opacity(0.5)
                            .font(.caption)
                        
                        // FIXME: - Пофиксить баг: при нажатии перекрашиваются все row
                        Button {
                            withAnimation(.spring(duration: 0.4, bounce: 0.0, blendDuration: 1)) {
                                isSafe.toggle()
                                dynamicSize = isSafe ? 23 : 20
                            }
                        } label: {
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: dynamicSize, height: dynamicSize)
                                .foregroundStyle(isSafe ? .orange : .black)
                        }
                        .frame(width: 30, height: 30)
                        .padding(.leading, 100)
                        .padding(.trailing, 10)
                        .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

#Preview {
    NewsList(isSafe: Binding(projectedValue: .constant(false)), imagePath: [ "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
        "https://nystudio107.com/img/blog/_1200x675_crop_center-center_82_line/image_optimzation.jpg",
        "https://cc-prod.scene7.com/is/image/CCProdAuthor/d-03-4?$pjpeg$&jpegSize=200&wid=720",
        "https://t4.ftcdn.net/jpg/03/96/00/75/360_F_396007562_FPXMDvZROZp0Cnnn4hLX2Zs5zBPyQTFV.jpg",
    ])
}
