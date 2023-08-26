import Foundation
///for CLLocationCoordinate2D
import MapKit

///location model
struct Location {
    
    let name: String?
    let cityName: String?
    let coordinates: CLLocationCoordinate2D?
    let description: String?
    let imageNames: [String?]
    
}

///conform Identifiable for using at list
extension Location: Identifiable {
    
    var id: String? {
        (name ?? String()) + (cityName ?? String())
    }
}

///conform Equatable for .animate our text
extension Location: Equatable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
