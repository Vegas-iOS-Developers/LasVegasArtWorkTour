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
    
    var artworks: [Artwork]! = [Artwork]()
    var dataservice: DataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TestVC.viewDidLoad()")
        
        callDataService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        self.artworks = ArtworkParser.parse(response)
        
        print("self.artworks.count: \(self.artworks)")
//        performSegueWithIdentifier("ShowArtworkMap", sender: self.artworks)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("TestVC.prepareForSegue()")
        
        if (segue.identifier == "ShowArtworkMap") {
            print("TestVC.prepareForSegue(): segue.identifier == \"ShowMap\"")
            let artworkScreen = segue.destination as! ArtworkVC
            
                print("TestVC.prepareForSegue(): artworkScreen = segue.destinationViewController as? ArtWorkVC")
                if let artData = sender as? [Artwork] {
                    print("artData.count: \(artData.count)")
                    print("artData[0]: \(artData[0])")
                    print("artData[0].name: \(artData[0].name)")
                    artworkScreen.artworks = artData
                    print("TestVC.prepareForSegue(): artData = sender as? [Artwork]")
                }
            
        }
    }
    
    
    
}


