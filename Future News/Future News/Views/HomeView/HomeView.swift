
import SwiftUI


struct HomeView: View {
    @Environment(\.screenSize) private var screenSize
    
    @ObservedObject var newsVM = NewsViewModel()
    
    /// Свойство для появления PreviewNewsDetails
    @State private var isPresentedPreviewNewsDetails: Bool = false
    
    /// Свойство для появления алерта
    @Binding var isAppearAlertView: Bool
    
    /// Свойство для появления NewsDetails
    @State private var isPresentedNewsDetails = false
    
    /// Хранилище для выбранного News в AllNewsView
    @State private var selectedNewsForPreviewDetails: News?
    
    /// Свойство описывающее, выбран ли флажок для сохранения новости
    @State private var isSafeNews = false
    
    /// Свойство для появления NewsDetails
    @State private var showDestinationSearchView = false
    
    /// Свойство описывающее, выбранную тему новостей
    @State private var selectedIndex = 0
    
    /// Свойство для появления LoadingScreen
    @State private var isLoading = true
    
    // TODO: - Create downloader photos
    let imagePath = [
        "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
        "https://nystudio107.com/img/blog/_1200x675_crop_center-center_82_line/image_optimzation.jpg",
        "https://cc-prod.scene7.com/is/image/CCProdAuthor/d-03-4?$pjpeg$&jpegSize=200&wid=720",
        "https://t4.ftcdn.net/jpg/03/96/00/75/360_F_396007562_FPXMDvZROZp0Cnnn4hLX2Zs5zBPyQTFV.jpg",
    ]
    
    let titles: [String] = ["All News",
                            "Business",
                            "Politics",
                            "Tech",
                            "Science",
                            "Games",
                            "Sport"
                           ]
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            
            if showDestinationSearchView {
                DestinationSearchView(isShow: $showDestinationSearchView)
            } else {
                VStack {
                    VStack {
                        SearchView()
                            .padding(.horizontal)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    showDestinationSearchView.toggle()
                                }
                            }
                            .zIndex(1.0)
                        
                        Text("The quota has been exhausted!")
                            .foregroundStyle(.white)
                            .font(.system(size: 15))
                            .fontDesign(.rounded)
                            .fontWeight(.semibold)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.red)
                                    .frame(width: 250, height: 40, alignment: .bottom)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 3)
                                            .foregroundStyle(Color(.systemGray4))
                                            .shadow(radius: 3)
                                    }
                            }
                            .offset(y: newsVM.isFailedStatusCode ? 0 : -40)
                            .animation(.bouncy(duration: 0.7), value: newsVM.isFailedStatusCode)
                            .animation(.linear) { $0.opacity(newsVM.isFailedStatusCode ? 1 : 0) }
                            .onChange(of: newsVM.isFailedStatusCode) { _, newValue in
                                newsVM.isFailedStatusCode = newValue
                            }
                    }
                    
                    ZStack {
                        ScrollView {
                            VStack {
                                SegmentedView(selectedIndex: $selectedIndex, titles: titles)
                                    .zIndex(1.0)
                                    .padding(.horizontal)
                                    .onChange(of: selectedIndex) { newSelectedIndex in
                                        loadNews(for: newSelectedIndex)
                                    }
                                
                                HStack {
                                    Text("News is loading. Please wait!")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 15))
                                        .fontDesign(.rounded)
                                        .fontWeight(.semibold)
                                        .padding(.trailing, 10)
                                    
                                    ProgressView()
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.black)
                                        .frame(width: 300, height: 25, alignment: .bottom)
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(lineWidth: 3)
                                                .foregroundStyle(Color(.systemGray4))
                                                .shadow(radius: 3)
                                        }
                                }
                                .offset(x: isLoading ? 0 : -(screenSize.height))
                                .animation(.smooth(duration: 1), value: isLoading)
                                .animation(.linear) { $0.opacity(isLoading ? 1 : 0) }
                                .onAppear {
                                    isLoading = true
                                }
                            }
                            
                            if let news = newsVM.searchNews?.news {
                                AllNewsView(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails, isPresentedNewsDetails: $isPresentedNewsDetails, news: news, imagePath: imagePath) { selectedNews in
                                    self.selectedNewsForPreviewDetails = selectedNews
                                }
                                .id(selectedIndex)
                                .onAppear {
                                    isAppearAlertView = false
                                    isLoading = false
                                }
                            } else {
                                LoadingScreen()
                                    .id(selectedIndex)
                                    .onAppear {
                                        isLoading = true
                                        loadNews(for: selectedIndex)
                                    }
                                    .blur(radius: isAppearAlertView ? 10.0 : 0.0)
                            }
                        }
                        .allowsHitTesting(!isAppearAlertView)
                        
                        AlertView(isAppearAlertView: $isAppearAlertView)
                    }
                }
                .blur(radius: isPresentedPreviewNewsDetails ? 10 : 0.0)
                .allowsHitTesting(!isPresentedPreviewNewsDetails)
            }
            
            PreviewNewsDetails(
                isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                isSafe: $isSafeNews,
                dynamicSize: .constant(20),
                isPresentedNewsDetails: $isPresentedNewsDetails,
                news: selectedNewsForPreviewDetails ?? News(id: 0,
                                                            title: "",
                                                            text: "",
                                                            url: "",
                                                            image: "",
                                                            publishDate: "",
                                                            language: "",
                                                            sourceCountry: "",
                                                            sentiment: 0.0,
                                                            author: nil)
            )
            .opacity(isPresentedPreviewNewsDetails ? 1 : 0.0)
        }
    }
    
    private func loadNews(for index: Int) {
        switch index {
        case 0:
            newsVM.fetchSearchNews(parameters: [.text: "All News"])
        case 1:
            newsVM.fetchSearchNews(parameters: [.text: "Business"])
        case 2:
            newsVM.fetchSearchNews(parameters: [.text: "Politics"])
        case 3:
            newsVM.fetchSearchNews(parameters: [.text: "Tech"])
        case 4:
            newsVM.fetchSearchNews(parameters: [.text: "Science"])
        case 5:
            newsVM.fetchSearchNews(parameters: [.text: "Games"])
        case 6:
            newsVM.fetchSearchNews(parameters: [.text: "Sport"])
        default:
            newsVM.fetchSearchNews()
        }
    }
}

#Preview {
    HomeView(isAppearAlertView: .constant(true))
}
