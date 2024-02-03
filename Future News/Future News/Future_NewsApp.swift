
import SwiftUI

@main
struct Future_NewsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext,
                              CoreDataService.shared.context)
        }
    }
}
