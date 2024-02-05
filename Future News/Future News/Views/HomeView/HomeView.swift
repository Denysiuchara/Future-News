
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
    
    @Binding var isShowDestinationSV: Bool

    var body: some View {
        ZStack {
            Color(.colorSet3)
                .ignoresSafeArea()
            
            VStack {
                SearchViewContainer(showDestinationSearchView: $isShowDestinationSV)
                    .allowsHitTesting(!isPresentedPreviewNewsDetails)
                    .blur(radius: isPresentedPreviewNewsDetails ? 10 : 0)
                
                SegmentedViewContainer(selectedIndex: $selectedIndex)
                    .allowsHitTesting(!isPresentedPreviewNewsDetails)
                    .blur(radius: isPresentedPreviewNewsDetails ? 10 : 0)
                
                AllNewsView(isPresentedPreviewNewsDetails: $isPresentedPreviewNewsDetails)
            }
            .sheet(isPresented: $isShowDestinationSV) {
                DestinationSearchView(isShow: $isShowDestinationSV)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isShowDestinationSV = true
                        }
                    }
                    .onDisappear {
                        withAnimation(.bouncy) {
                            isShowDestinationSV = false
                        }
                    }
            }
        }
    }
}

#Preview {
    HomeView(isPresentedPreviewNewsDetails: .constant(false),
             isShowDestinationSV: .constant(false))
}
