//
//  Artwork.swift
//  LasVegasArtWorkTour
//
//  Created by William Jones on 10/30/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import MapKit
import UIKit

class ArtWork: NSObject, MKAnnotation {
    
    private var _coordinate: CLLocationCoordinate2D
    private var _name: String
    private var _desc: String
    private var _picURL: String
    private var _artist: String
    private var _type: String
    
    var name: String {
        return _name
    }
    
    var desc: String {
        return _desc
    }
    
    var picURL: String {
        return _picURL
    }
    
    var artist: String {
        return _artist
    }
    
    var type: String {
        return _type
    }
    
    var coordinate: CLLocationCoordinate2D {
        return _coordinate
    }
    
    var title: String? {
        return _name
    }
    
    var subtitle: String? {
        return _artist
    }
    
    init(name: String, desc: String, picURL:String, artist: String, type: String, coordinate: CLLocationCoordinate2D) {
        self._name = name
        self._desc = desc
        self._picURL = picURL
        self._artist = artist
        self._type = type
        self._coordinate = coordinate
    }
}

