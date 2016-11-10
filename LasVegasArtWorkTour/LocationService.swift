//
//  LocationService.swift
//  LasVegasArtWorkTour
//
//  Created by Joel Bell on 11/6/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    
    static private let MetersPerMile: CLLocationDistance = 1609.344
    
    /**
     * miles(from:) -> CLLocationDistance
     *
     * Easily get the distance in miles between two CLLocation's
     */
    func miles(from location: CLLocation) -> CLLocationDistance {
        let metersFromHere = self.distance(from: location)
        let milesFromHere = metersFromHere / CLLocation.MetersPerMile
        return milesFromHere
    }
}

enum LocationServiceError: Error {
    case notAuthorized
    case noResult
}

enum LocationServiceResult {
    case success(location: CLLocation)
    case failure(error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    fileprivate lazy var _locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    /**
     * completion
     *
     * Closure that is called when location fetching has completed.
     */
    internal var completion: ((LocationServiceResult) -> Void)?
    
    /**
     * fetchLocation(:completion)
     *
     * Fetches the current location, sends back result in completion handler.
     */
    internal func fetchLocation(completion: @escaping (LocationServiceResult) -> Void) {
        
        self.completion = completion
        
        switch CLLocationManager.authorizationStatus() {
        case .denied, .restricted:
            let result = LocationServiceResult.failure(error: LocationServiceError.notAuthorized)
            completion(result)
        case .notDetermined:
            _locationManager.requestWhenInUseAuthorization()
            fallthrough
        case .authorizedAlways, .authorizedWhenInUse:
            _locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // If the error passed back is a "denied" error, lets create our own
        // notAuthorized error to return so we keep the API consistent.
        // Mainly this is encountered if the user is presented with
        // the option to allow, but hits deny.
        var error = error as Error
        if (error as! CLError).code == .denied {
            error = LocationServiceError.notAuthorized
        }
        
        let result = LocationServiceResult.failure(error: error)
        self.completion?(result)
        self.completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            let result = LocationServiceResult.failure(error: LocationServiceError.noResult)
            self.completion?(result)
            self.completion = nil
            return
        }
        let result = LocationServiceResult.success(location: newLocation)
        self.completion?(result)
        self.completion = nil
    }
}

