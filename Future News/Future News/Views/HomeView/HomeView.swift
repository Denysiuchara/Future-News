
import SwiftUI


struct HomeView: View {
    @ObservedObject var newsVM = NewsViewModel()
    
    @State private var isChanged = false
    @State private var isSafe = false
    @State private var showDestinationSearchView = false
    @State private var selectedIndex = 0
    
    // TODO: - Create downloader photos
    let imagePath = [ "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
        "https://nystudio107.com/img/blog/_1200x675_crop_center-center_82_line/image_optimzation.jpg",
        "https://cc-prod.scene7.com/is/image/CCProdAuthor/d-03-4?$pjpeg$&jpegSize=200&wid=720",
        "https://t4.ftcdn.net/jpg/03/96/00/75/360_F_396007562_FPXMDvZROZp0Cnnn4hLX2Zs5zBPyQTFV.jpg",
    ]
    
    let titles: [String] =
        ["All News",
         "Business",
         "Politics",
         "Tech",
         "Science",
         "Games",
         "Sport"
        ]
    
    var body: some View {
        ZStack {
            Color(.backround)
                .ignoresSafeArea()
            
            if showDestinationSearchView {
                DestinationSearchView(isShow: $showDestinationSearchView)
            } else {
                VStack {
                    SearchView()
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                showDestinationSearchView.toggle()
                            }
                        }
                    
                    ScrollView {
                        
                        // FIXME: - Check if this code works
                        SegmentedView(selectedIndex: $selectedIndex, titles: titles)
                            .padding(.horizontal)
                            .onChange(of: selectedIndex) { _, _ in
                                switch selectedIndex {
                                case 0:
                                    isChanged = false
                                    newsVM.fetchSearchNews(parameters: [.text: "All News"])
                                    isChanged = true
                                case 1:
                                    isChanged = false
                                    newsVM.fetchSearchNews(parameters: [.text: "Business"])
                                    isChanged = true
                                case 2:
                                    isChanged = false
                                    newsVM.fetchSearchNews(parameters: [.text: "Politics"])
                                    isChanged = true
                                case 3:
                                    isChanged = false
                                    newsVM.fetchSearchNews(parameters: [.text: "Tech"])
                                    isChanged = true
                                case 4:
                                    isChanged = false
                                    newsVM.fetchSearchNews(parameters: [.text: "Science"])
                                    isChanged = true
                                case 5:
                                    isChanged = false
                                    newsVM.fetchSearchNews(parameters: [.text: "Games"])
                                    isChanged = true
                                case 6:
                                    isChanged = false
                                    newsVM.fetchSearchNews(parameters: [.text: "Sport"])
                                    isChanged = true
                                default :
                                    isChanged = false
                                    newsVM.fetchSearchNews()
                                    isChanged = true
                                }
                            }
                        
                        // FIXME: - Check if isChanged works
                        // TODO: - Add the ability to select news views
                        if isChanged == true, let news = newsVM.searchNews?.news {
                            AllNewsView(news: news, imagePath: imagePath)
                        } else {
                            EmptyNewsView()
                            ProgressView()
                                .onAppear {
                                    isChanged = false
                                    newsVM.fetchSearchNews(parameters: [.text: "All News"])
                                    isChanged = true
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
