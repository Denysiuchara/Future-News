//
//  NewsList.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct NewsList: View {
    @Binding var isSafe: Bool
    var imagePath: [String]
    
    var body: some View {
        ForEach(imagePath.indices) { index in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.newsRow)
                    .opacity(0.2)
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
                        .padding([.bottom], 50)
                        .padding([.leading], 20)
                        
                        // TODO: - Сделать так чтобы нижние элементы не двигались при заголовке в 1 и 2 линии
                        // TODO: - Разобратся из цветами: карточка под картинкой плохо видна
                        VStack(alignment: .leading) {
                            Text("**Some text for testing with line limit 2**")
                                .lineLimit(2)
                                .padding([.leading], 5)
                                .padding([.bottom], 20)
                            
                            HStack {
                                Text("1 hour ago")
                                    .font(.caption)
                                    .padding([.leading], 5)
                                
                                Spacer()
                                
                                // TODO: - Добавить скейлинг при нажатии
                                // FIXME: - Пофиксить баг: при нажатии перекрашиваются все row
                                Button {
                                    isSafe.toggle()
                                } label: {
                                    Image(systemName: "bookmark.fill")
                                        .foregroundStyle(isSafe ? .orange : .black)
                                }
                                .padding()
                            }
                        }
                        
                        
                        Spacer()
                    }
                    
                }
            }
            .padding([.vertical], 5)
            .frame(maxWidth: .infinity)
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
