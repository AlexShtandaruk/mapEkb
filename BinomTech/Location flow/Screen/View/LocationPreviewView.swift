import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    let location: Location
    
    var body: some View {
        
        HStack(alignment: .bottom) {
            
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack {
                ///more button
                button(title: "Узнать больше") {
                    locationViewModel.sheetLocationDetail = location
                }
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
                
                ///next button
                button(title: "Следующее") {
                    locationViewModel.nextButtonTapped()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.indigo)
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(.ultraThinMaterial)
            .offset(y: 65)
        )
        .clipped()
        .cornerRadius(10)
    }
}

///extension for work with description of sections
extension LocationPreviewView {
    
    private var imageSection: some View {
        
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName ?? String())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
                
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading) {
            Text(location.name ?? String())
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName ?? String())
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func button(title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
                .frame(width: 125, height: 25)
        }
    }
}

///preview
struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.indigo.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }
        .environmentObject(LocationViewModel())
    }
}
