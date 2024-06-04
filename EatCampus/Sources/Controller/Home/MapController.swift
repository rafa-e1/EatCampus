//
//  MapController.swift
//  EatCampus
//
//  Created by RAFA on 5/31/24.
//

import CoreLocation
import UIKit

import NMapsMap

final class MapController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MapView()
    private var locationManager: CLLocationManager?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
//        checkLocationAuthorization()
        configureLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: - Helpers
    
    private func configureLocation() {
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager?.startUpdatingLocation()
        
        let cameraUpdate = NMFCameraUpdate(scrollTo:  NMGLatLng(
            lat: locationManager?.location?.coordinate.latitude ?? 0,
            lng: locationManager?.location?.coordinate.longitude ?? 0
        ))
        
        cameraUpdate.animation = .easeIn
        cameraUpdate.animationDuration = 2
        mapView.naverMapView.mapView.moveCamera(cameraUpdate)
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("위치 정보 접근이 제한되었습니다.")
        case .denied:
            print("위치 정보 접근을 거절했습니다. 설정으로 이동해서 변경해주세요.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Success")
        @unknown default:
            fatalError()
        }
    }
}

extension MapController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        <#code#>
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
//        <#code#>
//    }
}
