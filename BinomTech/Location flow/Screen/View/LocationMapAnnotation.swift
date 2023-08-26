import SwiftUI

struct LocationMapAnnotationView: View {
    
    let location: Location
    
    var body: some View {
        
        ///annotation icon
        ZStack {
            Image(Images.tracker)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .foregroundColor(.indigo)
            Image(location.imageNames.first! ?? String())
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .cornerRadius(15)
                .offset(y:-4)
        }
        .padding(.bottom, 40)
    }
}

/// extension enum of images
extension LocationMapAnnotationView {
    
    enum Images {
        static let tracker = "ic_tracker_75dp"
    }
}

///preview
struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotationView(location: LocationsDataService.locations.first!)
    }
}
