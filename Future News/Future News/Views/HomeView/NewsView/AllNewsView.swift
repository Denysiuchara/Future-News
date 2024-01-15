//
//  AllNewsView.swift
//  Future News
//
//  Created by Danya Denisiuk on 10.12.2023.
//

import SwiftUI

struct AllNewsView: View {
    @State var news: [News]
    @State var isSafe = false
    var imagePath: [String]
    
    var body: some View {
        ScrollView {
            
            // TODO: - Add more information in CardView, and add destination to tap
            TabCard(imagePath: imagePath)
                .frame(height: 300)
            
            
            HStack {
                Text("Latest news")
                    .fontDesign(.rounded)
                    .font(.title)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Divider()
            
            // TODO: - Add scrolling with news
            NewsList(isSafe: $isSafe, news: news)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AllNewsView(
        news: [
            News(id: 0,
                 title: "First Title Text",
                 text: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                 url: "url//url//url//url//url//urlurl//url//url",
                 image: "",
                 publishDate: "00.00.00 00:00",
                 language: "en",
                 sourceCountry: "USA",
                 sentiment: 0.3,
                 author: "Anton"),
            News(id: 1,
                 title: "Second Title Text",
                 text: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                 url: "url//url//url//url//url//urlurl//url//url",
                 image: "",
                 publishDate: "11.11.11 11:11",
                 language: "en",
                 sourceCountry: "USA",
                 sentiment: 0.3,
                 author: "Some Author wit long name"),
            News(id: 2,
                 title: "Third Title Text",
                 text: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                 url: "url//url//url//url//url//urlurl//url//url",
                 image: "",
                 publishDate: "22.22.22 22:22",
                 language: "en",
                 sourceCountry: "USA",
                 sentiment: 0.3,
                 author: nil),
            News(id: 3,
                 title: "Fourth Title Text",
                 text: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                 url: "url//url//url//url//url//urlurl//url//url",
                 image: "",
                 publishDate: "33.33.33 33:33",
                 language: "en",
                 sourceCountry: "USA",
                 sentiment: 0.3,
                 author: "David")
        ],
        imagePath: [
            "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
            "https://nystudio107.com/img/blog/_1200x675_crop_center-center_82_line/image_optimzation.jpg",
            "https://cc-prod.scene7.com/is/image/CCProdAuthor/d-03-4?$pjpeg$&jpegSize=200&wid=720",
            "https://t4.ftcdn.net/jpg/03/96/00/75/360_F_396007562_FPXMDvZROZp0Cnnn4hLX2Zs5zBPyQTFV.jpg",
        ]
    )
}
