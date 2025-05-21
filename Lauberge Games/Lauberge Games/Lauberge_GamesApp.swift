import SwiftUI

@main
struct Lauberge_GamesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            LaubergeRoot()
                .preferredColorScheme(.light)
        }
    }
}
