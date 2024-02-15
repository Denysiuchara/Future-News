
import SwiftUI


struct HomeView: View {
    @Environment(\.screenSize) private var screenSize
    @EnvironmentObject var newsVM: NewsViewModel
    
    @State private var selectedIndex = 0
    
    @State private var showDestinationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.colorSet3)
                .ignoresSafeArea()
            
            VStack {
                SearchViewContainer(showDestinationSearchView: $showDestinationSearchView)
                    .environmentObject(newsVM)
                
                SegmentedViewContainer()
                    .environmentObject(newsVM)
                
                AllNewsView(selectedIndex: $selectedIndex)
                    .environmentObject(newsVM)
            }
        }
    }
}

#Preview {
    HomeView()
}
