//
//  NaverMapManager.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/26/25.
//

import Foundation
import NMapsMap
import ComposableArchitecture
import Combine

final class NaverMapManager : NSObject, ObservableObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
    static let shared = NaverMapManager()
    private let locationManager = LocationManager.shared
    
    let view = NMFNaverMapView(frame: .zero)
    let specificMarker : NMFMarker = NMFMarker()
    
    @Published var coord: (Double, Double) = (0.0, 0.0)
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    
    /// Feature Send Subject
    let onMoveToSpecificLocation: PassthroughSubject<SearchMockData, Never> = .init()
    
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
        switch locationManager.getManager().authorizationStatus {
        case .notDetermined:
            Logger.debug("notDetermined")
            locationManager.getManager().requestWhenInUseAuthorization()
        case .restricted:
            Logger.debug("위치 정보 접근이 제한되었습니다.")
        case .denied:
            Logger.debug("위치 정보 접근을 거절했습니다. 설정에 가서 변경하세요.")
        case .authorizedAlways, .authorizedWhenInUse:
            Logger.debug("Success")
            
            coord = (locationManager.getCoordinates().latitude ?? 0.0, locationManager.getCoordinates().longitude ?? 0.0)
            userLocation = (locationManager.getCoordinates().latitude ?? 0.0, locationManager.getCoordinates().longitude ?? 0.0)
            
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
    
    /// SpecificLocation으로 이동하기
    func moveToSpecificLocation(location : SearchMockData) {
        Logger.debug("moveToSpecificLocation lat: \(location.latitude), lng: \(location.longitude) ✅✅✅✅")
        
        ///let specificLocation = NMGLatLng(lat: 37.566610, lng: 126.978388)
        let specificLocation = NMGLatLng(lat: location.latitude, lng: location.longitude)
        let cameraUpdate = NMFCameraUpdate(position: NMFCameraPosition(specificLocation, zoom: 15))

        view.mapView.moveCamera(cameraUpdate) { [weak self] isCancelled in
            guard let self else { return }
            
            if isCancelled {
                Logger.error("moveToSpecificLocation fail ❌❌❌❌")
            } else {
                Logger.debug("moveToSpecificLocation success ✅✅✅✅")
                onMoveToSpecificLocation.send(location)
                
                /// set Marker
                setSpecificLocationMaker(location: location)
            }
        }
    }
    
    /// Specific Location에서 나의 위치로 이동하기
    func cancelSpecificLocation() {
        Logger.debug("cancelSpecificLocation ✅✅✅✅")
        fetchUserLocation(withAnimation: false)
        removeSpecificMarker()
    }
    
    /// Specific Marker 지우기
    private func removeSpecificMarker() {
        specificMarker.mapView = nil
    }
    
    /// 나의 위치로 이동하기
    private func fetchUserLocation(withAnimation : Bool = true) {
        if let lat = locationManager.getCoordinates().latitude, let lng = locationManager.getCoordinates().longitude {
            Logger.debug("fetchUserLocation Success ✅")
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 15)
            
            if withAnimation {
                cameraUpdate.animation = .easeIn
                cameraUpdate.animationDuration = 0.5
            }
            
            view.mapView.moveCamera(cameraUpdate)
        } else {
            Logger.warning("fetchUserLocation Fail ❌")
        }
    }
    
    /// 특정위치에 Specific Marker 생성하기
    private func setSpecificLocationMaker(location : SearchMockData) {
        specificMarker.position = NMGLatLng(lat: location.latitude, lng: location.longitude)
        specificMarker.captionText = location.placeName
        specificMarker.captionTextSize = 12
        specificMarker.captionColor = UIColor(hexCode: ColorSystem.grayG800.uIntToString)
        specificMarker.captionHaloColor = UIColor(hexCode: ColorSystem.white.uIntToString)
        
        specificMarker.mapView = view.mapView
    }
}

private enum NaverMapManagerKey: DependencyKey {
    static var liveValue: NaverMapManager = NaverMapManager.shared
}

extension DependencyValues {
    var naverMapManager: NaverMapManager {
        get { self[NaverMapManagerKey.self] }
        set { self[NaverMapManagerKey.self] = newValue }
    }
}

//    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
//        // 카메라 이동이 시작되기 전 호출되는 함수
//        Logger.debug("cameraWillChangeByReason")
//    }
//
//    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
//        // 카메라의 위치가 변경되면 호출되는 함수
//        Logger.debug("cameraIsChangingByReason")
//    }
