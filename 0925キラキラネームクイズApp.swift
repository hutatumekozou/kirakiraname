import SwiftUI

@main
struct AppEntry {
    static func main() {
        if #available(iOS 14.0, *) {
            KiraKiraNameQuizApp.main()
        } else {
            fatalError("iOS 14.0+ required")
        }
    }
}

@available(iOS 14.0, *)
struct KiraKiraNameQuizApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
