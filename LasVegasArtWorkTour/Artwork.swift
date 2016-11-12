//
//  Artwork.swift
//  LasVegasArtWorkTour
//
//  Created by William Jones on 10/30/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import MapKit
import UIKit

class Artwork: NSObject, MKAnnotation {
    
    private var _coordinate: CLLocationCoordinate2D
    private var _name: String
    private var _desc: String
    private var _locationDesc: String
    private var _picURL: String
    private var _artist: String
    private var _type: String
    
    var name: String {
        return _name
    }
    
    var desc: String {
        return _desc
    }
    
    var locationDesc: String {
        return _locationDesc
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
    
    init(name: String, desc: String, locationDesc: String, picURL:String, artist: String, type: String, coordinate: CLLocationCoordinate2D) {
        self._name = name
        self._desc = desc
        self._locationDesc = locationDesc
        self._picURL = picURL
        self._artist = artist
        self._type = type
        self._coordinate = coordinate
    }
    
    // For print() statements
    override var description: String {
        return "\n\tname: \(self.name)\n\tdesc: \(self.desc)\n\tlocationDesc: \(self.locationDesc)\n\tpicURL: \(self.picURL)\n\tartist: \(self.artist)\n\ttype: \(self.type)\n\tcoordinate: \(self.coordinate)\n\ttitle: \(self.title)\n\tsubtitle: \(self.subtitle)\n"
    }
    
}

