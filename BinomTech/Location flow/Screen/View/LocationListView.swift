import SwiftUI

struct LocationListView: View {
    
    ///location view model
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        List {
            ForEach(locationViewModel.locations) { location in
                Button {
                    locationViewModel.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                        .listRowBackground(Color.white)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

///for work with description of layers
extension LocationListView {
    
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName ?? String())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 55)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(location.name ?? String())
                    .font(.headline)
                Text(location.cityName ?? String())
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.indigo)
        }
    }
}

///preview
struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationViewModel())
    }
}
