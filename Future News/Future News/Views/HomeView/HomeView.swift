
import SwiftUI


struct HomeView: View {
    @Environment(\.screenSize) private var screenSize
    
    @ObservedObject var newsVM = NewsViewModel()
    
    /// Свойство для появления алерта
    @Binding var isAppearAlertView: Bool
    
    @Binding var isAppearDestinationSearchView: Bool
    
    /// Свойство для появления PreviewNewsDetails
    @State private var isPresentedPreviewNewsDetails = false
    
    /// Свойство для появления NewsDetails
    @State private var isPresentedNewsDetails = false
    
    /// Свойство для появления DestinationSearchView
    @State private var showDestinationSearchView = false
    
    /// Свойство описывающее, выбранную тему новостей
    @State private var selectedIndex = 0
    
    @FetchRequest(fetchRequest: NewsEntity.fetch(), animation: .default)
    private var items: FetchedResults<NewsEntity>
    
    var body: some View {
        ZStack {
            Color(.colorSet3)
                .ignoresSafeArea()
            
            if showDestinationSearchView {
                DestinationSearchView(isShow: $showDestinationSearchView)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isAppearDestinationSearchView = true
                        }
                    }
                    .onDisappear {
                        withAnimation(.bouncy) {
                            isAppearDestinationSearchView = false
                        }
                    }
            } else {
                VStack {
                    SearchViewContainer(showDestinationSearchView: $showDestinationSearchView)
                    
                    SegmentedViewContainer(selectedIndex: $selectedIndex)
                    
                    ZStack {
                        AllNewsView(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails,
                                    isPresentedNewsDetails: $isPresentedNewsDetails,
                                    isAppearAlertView: $isAppearAlertView)
                        
                        AlertView(isAppearAlertView: $isAppearAlertView)
                    }
                }
                .blur(radius: isPresentedNewsDetails ? 10.0 : 0.0 )
                .allowsHitTesting(!isPresentedPreviewNewsDetails)
            }
        }
    }
}

#Preview {
    HomeView(isAppearAlertView: .constant(true), isAppearDestinationSearchView: .constant(false))
}
