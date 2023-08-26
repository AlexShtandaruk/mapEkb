import SwiftUI

final class Builder: ObservableObject {
    
    func instanceLocationScreen() -> some View {
        LocationScreen(locationViewModel: LocationViewModel())
    }
}
