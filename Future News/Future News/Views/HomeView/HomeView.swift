
import SwiftUI


struct HomeView: View {
    @Environment(\.screenSize) private var screenSize
    
    @ObservedObject private var newsVM = NewsViewModel()
    
    /// Свойство описывающее, выбранную тему новостей
    @State private var selectedIndex = 0
    
    @FetchRequest(fetchRequest: NewsEntity.fetch(), animation: .default)
    private var items: FetchedResults<NewsEntity>
    
    /// Свойство для появления PreviewNewsDetails
    @Binding var isPresentedPreviewNewsDetails: Bool
    
    @State private var showDestinationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.colorSet3)
                .ignoresSafeArea()
            
            VStack {
                SearchViewContainer(showDestinationSearchView: $showDestinationSearchView)
                    .allowsHitTesting(!isPresentedPreviewNewsDetails)
                    .blur(radius: isPresentedPreviewNewsDetails ? 10 : 0)
                
                SegmentedViewContainer(selectedIndex: $selectedIndex)
                    .allowsHitTesting(!isPresentedPreviewNewsDetails)
                    .blur(radius: isPresentedPreviewNewsDetails ? 10 : 0)
                
                AllNewsView(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails)
            }
        }
    }
}

#Preview {
    HomeView(isPresentedPreviewNewsDetails: .constant(false))
}
