//
//  ArtworkParser.swift
//  LasVegasArtWorkTour
//
//  Created by Joel Bell on 11/4/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

struct ArtworkParser {
    
    static internal func parse(_ data: [[String: Any]]) -> [Artwork] {
        let parser = ArtworkParser()
        return parser.parseCollection(data)
    }
    
    internal func parseCollection(_ data: [[String: Any]]) -> [Artwork] {
        let json = JSON(data)
        var artworks = [Artwork]()
        for (_, artRecord):(String, JSON) in json {
            artworks.append(self.parseArtwork(artRecord))
        }
        return artworks
    }
    
    internal func parseArtwork(_ artRecord: JSON) -> Artwork {
        let artName = artRecord["name"].stringValue
        let artDesc = artRecord["description"].stringValue
        let artArtist = artRecord["artist"].stringValue
        let artType = artRecord["type"].stringValue
        let artURL = artRecord["path"].stringValue
        let artGeoLocLat = artRecord["location_1"]["coordinates"][1].stringValue
        let artGeoLocLon = artRecord["location_1"]["coordinates"][0].stringValue
        let locationDesc = artRecord["location"].stringValue
        
        let lat = (artGeoLocLat as NSString).doubleValue
        let lon = (artGeoLocLon as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let art = Artwork(name: artName, desc: artDesc, locationDesc: locationDesc, picURL: artURL, artist: artArtist, type: artType, coordinate: coordinate)
        return art
    }
    
}
