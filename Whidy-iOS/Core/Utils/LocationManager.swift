//
//  LocationManager.swift
//  Whidy-iOS
//
//  Created by JinwooLee on 1/29/25.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    private(set) var altitude: Double?
    private(set) var latitude: Double?
    private(set) var longitude: Double?
    
    override private init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getManager() -> CLLocationManager {
        return locationManager
    }
    
    // 위도 및 경도 반환 함수
    func getCoordinates() -> (latitude: Double?, longitude: Double?) {
        return (latitude, longitude)
    }
    
    // CLLocationManagerDelegate 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        altitude = location.altitude
        
//        Logger.debug("getCoordinates() - latitude: \(latitude ?? 0.0), longitude: \(longitude ?? 0.0)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.error("Failed to find user's location: \(error.localizedDescription)")
    }
}
