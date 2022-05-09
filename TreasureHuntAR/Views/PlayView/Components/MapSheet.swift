//
//  MapSheet.swift
//  TreasureHuntAR
//
//  Created by MacBook on 08/05/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}



struct MapSheet: View {
    @ObservedObject var presenter: PlayViewPresenter
    
    
    @State private var region: MKCoordinateRegion
    var markers: [Marker]? = nil
    
    
    init(presenter: PlayViewPresenter) {
        self.presenter = presenter
        
        markers = [Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: presenter.startLocation!.coordinate.latitude, longitude: presenter.startLocation!.coordinate.longitude), tint: .red))]
        
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: presenter.startLocation!.coordinate.latitude, longitude: presenter.startLocation!.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                TabView {
                    Image(uiImage:  presenter.startLocationImage!.rotate(radians: 90 * .pi/180)!).resizable().centerCropped()
                        .tabItem {
                            Image(systemName: "photo.fill")
                            Text("Screenshot")
                        }.edgesIgnoringSafeArea(.top)
                    Map(coordinateRegion: $region, showsUserLocation: true,
                        annotationItems: markers!) { marker in
                        marker.location
                    }.tabItem {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }.edgesIgnoringSafeArea(.top)
                    
                }
                    
                Button(action: {
                    self.presenter.showMapSheet = false
                }) {
                    Text("close").bold()
                }.padding()
                    .edgesIgnoringSafeArea(.all)
            }.fullScreen(alignment: .topTrailing).edgesIgnoringSafeArea(.all)
            
        }
    }
}



