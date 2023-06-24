//
//  LocationManager.swift
//  Speedometer
//
//  Created by user242911 on 6/23/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    static var shared: LocationManager = LocationManager()
    private let locationManager = CLLocationManager()
    
    @Published var speed: Double = 0
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    private var isPermissionGranted: Bool {
        return locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways
    }
    
    private var isGPSEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Additional setup for speed tracking
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .automotiveNavigation
        locationManager.startUpdatingLocation()
    }
    
    func isAvailable() -> Bool {
        return isPermissionGranted && isGPSEnabled
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        speed = location.speed
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        switch authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            enableLocationFeatures()
            break
            
        case .restricted, .denied:  // Location services currently unavailable.
            disableLocationFeatures()
            break
            
        case .notDetermined:        // Authorization not determined yet.
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func enableLocationFeatures() {
        
    }
    
    func disableLocationFeatures() {
        
    }
}
