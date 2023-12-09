
import SwiftUI


struct ContentView: View {
    // TODO: - Create native real category
    let newsCategory = [
        "All news",
        "Business",
        "Politics",
        "Tech",
        "Science",
        "Game"
    ]
    
    // TODO: - Create downloader photos
    let imagePath = [ "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
        "https://nystudio107.com/img/blog/_1200x675_crop_center-center_82_line/image_optimzation.jpg",
        "https://cc-prod.scene7.com/is/image/CCProdAuthor/d-03-4?$pjpeg$&jpegSize=200&wid=720",
        "https://t4.ftcdn.net/jpg/03/96/00/75/360_F_396007562_FPXMDvZROZp0Cnnn4hLX2Zs5zBPyQTFV.jpg",
        ]
    
    var body: some View {
        VStack {
            HStack {
                SplitButton {
                    // TODO: Toggle theme
                }
                .padding([.horizontal])
                
                Spacer()
            }
            
            // TODO: - Add animation for pagecontrol
            SegmentedView(newsCategory: newsCategory)
            
            // TODO: - Add more information in CardView, and add destination to tap
            TabCard(imagePath: imagePath)
                .frame(height: 300)
            
            HStack{
                Text("Latest news")
                    .font(.title)
                    .padding()
                
                Spacer()
            }
            
            Spacer()
            
            // TODO: - Add scrolling with news
            
            // TODO: - Add tab bar with another views
        }
    }
}

#Preview {
    ContentView()
}
