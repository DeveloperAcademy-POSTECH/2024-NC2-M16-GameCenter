//
//  CustomMapView.swift
//  BingoLingo
//
//  Created by KimYuBin on 6/17/24.
//

import SwiftUI
import NMapsMap

struct CustomMapView: View {
    let markerLatitude: Double
    let markerLongitude: Double
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(.sRGB, red: 0.96, green: 0.96, blue: 0.96, opacity: 1.0))
            
            CustomMapViewRepresentable(markerLatitude: markerLatitude,
                                       markerLongitude: markerLongitude) {
                print("Marker touched")
            }

        }
        .navigationBarHidden(true)
    }
}

struct CustomMapViewRepresentable: UIViewRepresentable {
    let onMarkerTouched: () -> Void
    let markerLatitude: Double
    let markerLongitude: Double

    init(markerLatitude: Double, markerLongitude: Double, onMarkerTouched: @escaping () -> Void) {
        self.markerLatitude = markerLatitude
        self.markerLongitude = markerLongitude
        self.onMarkerTouched = onMarkerTouched
    }

    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView(frame: .zero)
        view.showCompass = true
        view.mapView.positionMode = .normal
        view.mapView.zoomLevel = 17
        view.mapView.addCameraDelegate(delegate: context.coordinator)

        let coord = NMGLatLng(lat: markerLatitude, lng: markerLongitude)
        view.mapView.moveCamera(NMFCameraUpdate(scrollTo: coord))

        let marker = NMFMarker(position: coord)
        if let customMarkerImage = UIImage(named: "imgPin") {
            marker.iconImage = NMFOverlayImage(image: customMarkerImage)
        }
        marker.mapView = view.mapView
        marker.touchHandler = { _ in
            self.onMarkerTouched()
            return true
        }

        return view
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, NMFMapViewCameraDelegate {
    }
}
