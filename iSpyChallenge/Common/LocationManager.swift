//
//  LocationManager.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/23/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let locationManager : CLLocationManager
    let mockedLocation =  CLLocation(latitude: 37.7904462, longitude: -122.4011537)
    var location: CLLocation?
    
    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        super.init()
        locationManager.delegate = self
    }
    
    //It would be a better experience if this would just call requestLocation(), but in practice I wasnt getting the one location back fast enough, so I just stop updating location when I get the first one back.
    func start() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location)
            self.location = location
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
