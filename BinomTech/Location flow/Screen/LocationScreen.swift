import SwiftUI
import MapKit

struct LocationScreen: View {
    
    ///location view model
    @StateObject private var locationViewModel: LocationViewModel
    
    ///DI
    init(locationViewModel: LocationViewModel) {
        _locationViewModel = StateObject(wrappedValue: locationViewModel)
    }
    var body: some View {
        
        ZStack {
            ZStack(alignment: .trailing) {
                mapLayer
                
                ///location button's
                VStack(spacing: 10) {
                    ///plus
                    makeLocationButton(image: Images.increase, completion: {
                        locationViewModel.increaseZoom()
                    })
                    ///minus
                    makeLocationButton(image: Images.decrease, completion: {
                        locationViewModel.decreaseZoom()
                    })
                    ///location
                    makeLocationButton(image: Images.location, completion: {
                        locationViewModel.requestAllowsOnceLocationsPermissions()
                    })
                    ///change type of map
                    makeLocationButton(image: Images.next, completion: {
                        locationViewModel.nextButtonTapped()
                    })
                }
                .padding()
            }
            ///header with city and place
            VStack(spacing: 0) {
                header
                Spacer()
                locationPreviewStack
            }
        }
        ///detail view
        .sheet(item: $locationViewModel.sheetLocationDetail) { location in
            LocationDetailView(location: location)
        }
        
        ///alert about geolocation deviation
        .alert(isPresented: $locationViewModel.permissionDenied) {
            Alert(
                title: Text("Permission denied"),
                message: Text("Please enable permission in App settings"),
                dismissButton: .default(
                    Text("Go to settings"),
                    action: {
                        UIApplication.shared.open(URL(
                            string: UIApplication.openSettingsURLString)!
                        )
                    }
                )
            )
        }
    }
}

///extension for work with description of layers
extension LocationScreen {
    
    private var header: some View {
        VStack {
            Button {
                locationViewModel.toggleLocationList()
            } label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(.indigo)
                        .opacity(locationViewModel.isShowListOfLocation ? 1 : 0.7)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                    Text((locationViewModel.mapLocation.cityName ?? String()) + ", " + (locationViewModel.mapLocation.name ?? String()))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 50)
                        .lineLimit(2)
                        .animation(.none, value: locationViewModel.mapLocation)
                        .overlay(alignment: .leading, content: {
                            Image(systemName: "arrow.down")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .rotationEffect(Angle(degrees: locationViewModel.isShowListOfLocation ? 180 : 0))
                        })
                    
                }
                .shadow(color: .black, radius: 20, x: 0, y: 15)
            }
            
            if locationViewModel.isShowListOfLocation {
                LocationListView()
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
    
    private var mapLayer: some View {
        Map(
            coordinateRegion: $locationViewModel.mapRegion,
            showsUserLocation: true,
            annotationItems: locationViewModel.locations,
            annotationContent: { location in
                /// ! normal 'case we hard code our data
                MapAnnotation(coordinate: location.coordinates!) {
                    LocationMapAnnotationView(location: location)
                        .scaleEffect(locationViewModel.mapLocation == location ? 1 : 0.8)
                        .onTapGesture {
                            locationViewModel.showNextLocation(location: location)
                        }
                }
            }
        )
        .ignoresSafeArea()
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(locationViewModel.locations) { location in
                if locationViewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .padding()
                        .shadow(color: .black, radius: 20, x: 0, y: 15)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                        .environmentObject(locationViewModel)
                }
            }
        }
    }
    
    private func makeLocationButton(image: String, completion: @escaping () -> Void) -> some View {
        Button {
            completion()
        } label: {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
        }
    }
}

/// extension enum of images
extension LocationScreen {
    
    enum Images {
        static let increase = "ic_zoom_plus_55dp"
        static let decrease = "ic_zoom_minus_55dp"
        static let location = "ic_mylocation_55dp"
        static let next = "ic_next_tracker_55dp"
    }
}

///preview
struct LocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationScreen(locationViewModel: LocationViewModel())
    }
}
