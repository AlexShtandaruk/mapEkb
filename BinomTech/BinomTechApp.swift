import SwiftUI

@main
struct BinomTechApp: App {
    
    @StateObject var builder: Builder = .init()
    
    var body: some Scene {
        WindowGroup {
            builder.instanceLocationScreen()
                .environmentObject(builder)
        }
    }
}
