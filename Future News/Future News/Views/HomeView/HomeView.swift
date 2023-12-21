
import SwiftUI


struct HomeView: View {
    @ObservedObject var newsVM = NewsViewModel()
    
    @State private var isSafe = false
    @State private var showDestinationSearchView = false
    @State private var selectedIndex = 0
    
    // TODO: - Create downloader photos
    let imagePath = [ "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
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
            Color(.backround)
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
                    
                    ScrollView {
                        // FIXME: - Check if this code works
                        SegmentedView(selectedIndex: $selectedIndex, titles: titles)
                            .padding(.horizontal)
                            .onChange(of: selectedIndex) { newSelectedIndex in
                                loadNews(for: newSelectedIndex)
                            }
                        
                        // FIXME: - Check if isChanged works
                        // TODO: - Add the ability to select news views
                        if let news = newsVM.searchNews?.news {
                            AllNewsView(news: news, imagePath: imagePath)
                                .id(selectedIndex)
                        } else {
                            EmptyNewsView()
                                .id(selectedIndex)
                                .onAppear {
                                    loadNews(for: selectedIndex)
                                }
                        }
                    }
                }
            }
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
    HomeView()
}
