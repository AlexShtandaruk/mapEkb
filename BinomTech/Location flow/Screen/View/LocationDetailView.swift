import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    ///location view model
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 15)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

///for work with description of layers
extension LocationDetailView {
    
    private var imageSection: some View {
        
        TabView {
            
            ForEach(location.imageNames, id: \.self) { image in
                Image(image ?? String())
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
            
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(location.name ?? String())
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName ?? String())
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(location.description ?? String())
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var mapLayer: some View {
        Map(
            coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: location.coordinates!,
                    span: locationViewModel.mapSpan
                )
            ),
            annotationItems: [location]) { location in
                MapAnnotation(coordinate: location.coordinates!) {
                    LocationMapAnnotationView(location: location)
                        .shadow(radius: 10)
                }
            }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton: some View {
        Button {
            locationViewModel.sheetLocationDetail = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
        
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationViewModel())
    }
}
