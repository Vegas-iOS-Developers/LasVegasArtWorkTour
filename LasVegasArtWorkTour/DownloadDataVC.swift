//
//  ViewController.swift
//  LasVegasArtWorkTour
//
//  Created by William Jones on 10/30/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit
import Alamofire

class DownloadDataVC: UIViewController {
    
    var artworks: [ArtWork]! = [ArtWork]()
    var dataservice: DataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TestVC.viewDidLoad()")
        
        callDataService()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("TestVC.viewWillAppear()")
        
    }
    
    func callDataService() {
        print("TestVC.callDataService()")
        let url = "https://opendata.lasvegasnevada.gov/resource/nefs-tayh.json"
        dataservice = DataService(url: url)
        print("TestVC.viewDidLoad(): dataservice = DataService(url: url)")
        dataservice.downloadDetails { () -> () in
            //this will be called after download is done
            print("TestVC.viewDidLoad(): calling loadArtData2()")
            self.loadArtData()
        }
    }
    
    func loadArtData() {
        print("TestVC.loadArtData()")
        
        let response = dataservice.response
        
        print("************************************")
        //print("response: \(response)")
        print("************************************")
        
        //let json = JSON(response)
        let json = JSON.parse(response)
        print("json.count: \(json.count)")
        
        for (_,artRecord):(String, JSON) in json {
            //print("\(artRecord)")
            
            let artName = artRecord["name"].stringValue
            //print("artName: \(artName)")
            let artDesc = artRecord["description"].stringValue
            //print("artDesc: \(artDesc)")
            let artArtist = artRecord["artist"].stringValue
            //print("artArtist: \(artArtist)")
            let artType = artRecord["type"].stringValue
            //print("artType: \(artType)")
            let artURL = artRecord["path"].stringValue
            //print("artURL: \(artURL)")
            let artGeoLocLat = artRecord["location_1"]["coordinates"][0].stringValue
            //print("artGeoLoc: \(artGeoLocLat)")
            let artGeoLocLon = artRecord["location_1"]["coordinates"][1].stringValue
            //print("artGeoLocLon: \(artGeoLocLon)")
            
            let lat = (artGeoLocLat as NSString).doubleValue
            let lon = (artGeoLocLon as NSString).doubleValue
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            let art = ArtWork(name: artName, desc: artDesc, picURL: artURL, latitude: artGeoLocLat, longitude: artGeoLocLon, artist: artArtist, type: artType, coordinate: coordinate)
            
            self.artworks.append(art)
        }
        
//        print("self.artworks.count: \(self.artworks.count)")
//        performSegueWithIdentifier("ShowArtworkMap", sender: self.artworks)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("TestVC.prepareForSegue()")
        
        if (segue.identifier == "ShowArtworkMap") {
            print("TestVC.prepareForSegue(): segue.identifier == \"ShowMap\"")
            let artworkScreen = segue.destinationViewController as! ArtworkVC
            
                print("TestVC.prepareForSegue(): artworkScreen = segue.destinationViewController as? ArtWorkVC")
                if let artData = sender as? [ArtWork] {
                    print("artData.count: \(artData.count)")
                    print("artData[0]: \(artData[0])")
                    print("artData[0].name: \(artData[0].name)")
                    artworkScreen.artworks = artData
                    print("TestVC.prepareForSegue(): artData = sender as? [ArtWork]")
                }
            
        }
    }
    
    
    
}


