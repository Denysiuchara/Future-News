
import SwiftUI

@main
struct Future_NewsApp: App {
    @ObservedObject private var newsVM = NewsViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    newsVM.fetchNews()
                }
                .environmentObject(newsVM)
                .environment(\.managedObjectContext,
                              CoreDataService.shared.context)
        }
    }
}
