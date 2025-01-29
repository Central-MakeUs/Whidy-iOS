//
//  NaverMapManager.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/26/25.
//

import Foundation
import NMapsMap

final class NaverMapManager : NSObject, ObservableObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
    static let shared = NaverMapManager()
    private let locationManager = LocationManager.shared.getManager()
    
    let view = NMFNaverMapView(frame: .zero)
    @Published var coord: (Double, Double) = (0.0, 0.0)
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    
    override init() {
        super.init()
        
        Logger.debug("NaverMapManager Init")
        
        view.mapView.positionMode = .direction
        view.mapView.isNightModeEnabled = true
        view.showLocationButton = true
        view.showZoomControls = false // 줌 확대, 축소 버튼 활성화
        view.showCompass = false
        view.showScaleBar = false
        
        view.mapView.addCameraDelegate(delegate: self)
        view.mapView.touchDelegate = self
    }
    
    func getNaverMapView() -> NMFNaverMapView {
        return view
    }
    
    // MARK: - 위치 정보 동의 확인
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            Logger.debug("notDetermined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            Logger.debug("위치 정보 접근이 제한되었습니다.")
        case .denied:
            Logger.debug("위치 정보 접근을 거절했습니다. 설정에 가서 변경하세요.")
        case .authorizedAlways, .authorizedWhenInUse:
            Logger.debug("Success")
            
            coord = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            
            fetchUserLocation()
            
        @unknown default:
            break
        }
    }
    
    func checkIfLocationServiceIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.checkLocationAuthorization()
                }
            } else {
                Logger.warning("Show an alert letting them know this is off and to go turn i on")
            }
        }
    }
    
    private func fetchUserLocation() {
        if let lat = locationManager.location?.coordinate.latitude, let lng = locationManager.location?.coordinate.longitude {
            Logger.debug("fetchUserLocation Success ✅")
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 15)
            cameraUpdate.animation = .easeIn
            cameraUpdate.animationDuration = 0.5
            
            view.mapView.moveCamera(cameraUpdate)
        } else {
            Logger.warning("fetchUserLocation Fail ❌")
        }
    }
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        // 카메라 이동이 시작되기 전 호출되는 함수
        Logger.debug("cameraWillChangeByReason")
    }
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        // 카메라의 위치가 변경되면 호출되는 함수
        Logger.debug("cameraIsChangingByReason")
    }
}
