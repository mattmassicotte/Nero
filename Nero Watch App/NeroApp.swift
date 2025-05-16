import SwiftUI

@main
struct Nero_Watch_AppApp: App {
	@State private var store = DataStore()
	
    var body: some Scene {
        WindowGroup {
			ContentView(store: store)
        }
    }
}
