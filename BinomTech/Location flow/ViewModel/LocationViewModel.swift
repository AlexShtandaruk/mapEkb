///swiftUI for withAnimation
import SwiftUI
import MapKit

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    ///all loaded locations
    @Published var locations: [Location]
    
    ///current location on the map
    @Published var mapLocation: Location {
        didSet {
            ///update region only when we've already changed the location
            updateMapRegion(location: mapLocation)
        }
    }
    
    ///current map region
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    ///show list of locations
    @Published var isShowListOfLocation: Bool = false
    
    ///show detail of locations
    @Published var sheetLocationDetail: Location? = nil
    
    ///for checking current permisson
    @Published var permissionDenied: Bool = false
        
    ///location manager
    let locationManager: CLLocationManager = CLLocationManager()
    
    ///default span
    let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    override init() {
        
        let locations = LocationsDataService.locations
        self.locations = locations
        
        ///its not fault - 'case locations hard code
        self.mapLocation = locations.first!
        super.init()
        locationManager.delegate = self
        mapRegion.span = mapSpan
        updateMapRegion(location: locations.first!)
    }
    
    ///for update current value map region
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates!,
                span: mapRegion.span)
        }
    }
    
    ///toggle appear list of location with animation
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            isShowListOfLocation.toggle()
        }
    }
    
    ///zoom map plus
    func increaseZoom() {
        withAnimation(.easeInOut) {
            self.mapRegion.span.latitudeDelta *= 0.6
            self.mapRegion.span.longitudeDelta *= 0.6
        }
    }
    
    ///zoom map plus
    func decreaseZoom() {
        withAnimation(.easeInOut) {
            self.mapRegion.span.latitudeDelta /= 0.6
            self.mapRegion.span.longitudeDelta /= 0.6
        }
    }
    
    ///show next location
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            isShowListOfLocation = false
        }
    }
    
    ///location preview -> logic button of show next location
    func nextButtonTapped() {
        
        ///get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else { return }
        
        ///check if the next index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            ///next index is not valid -> restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        ///next index is valid
        ///locations[nextIndex] -> it's safe 'case wa've already checked everything
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    ///check permissions
    func requestAllowsOnceLocationsPermissions() {
        withAnimation(.easeInOut) {
            locationManager.requestLocation()
        }
    }
    
    ///change authorizarion
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied:
            permissionDenied.toggle()
        case .authorizedAlways:
            manager.requestLocation()
        default:
            ()
        }
    }
    
    ///standard func location manager for find out errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    ///standard func location manager for update locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        DispatchQueue.main.async {
            self.mapRegion = MKCoordinateRegion(center: latestLocation.coordinate, span: self.mapRegion.span)
        }
    }
}
