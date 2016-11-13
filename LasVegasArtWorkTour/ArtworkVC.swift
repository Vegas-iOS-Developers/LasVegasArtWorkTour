//
//  ArtworkVC.swift
//  LasVegasArtWorkTour
//
//  Created by William Jones on 10/30/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit
import Alamofire

class ArtworkVC: UIViewController {
    
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
        let url = "https://opendata.lasvegasnevada.gov/resource/nefs-tayh.json"
        dataservice = DataService()
        dataservice.download(from: url) { response in
            switch response {
            case .success(let value):
                self.loadArt(data: value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadArt(data: [[String: Any]]) {
        print("TestVC.loadArtData()")
        
        self.artworks = ArtworkParser.parse(data)
        print("self.artworks.count: \(self.artworks)")
        
        performSegue(withIdentifier: "ShowArtworkMap", sender: self.artworks)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        print("TestVC.prepareForSegue()")
        
//        if (segue.identifier == "ShowArtworkMap") {
//            print("TestVC.prepareForSegue(): segue.identifier == \"ShowMap\"")
//            if let artworkScreen = segue.destination as? ArtWorkVC {
//                print("TestVC.prepareForSegue(): artworkScreen = segue.destinationViewController as? ArtWorkVC")
//                if let artData = sender as? [Artwork] {
//                    print("artData.count: \(artData.count)")
//                    print("artData[0]: \(artData[0])")
//                    print("artData[0].name: \(artData[0].name)")
//                    artworkScreen.artworks = artData
//                    print("TestVC.prepareForSegue(): artData = sender as? [Artwork]")
//                }
//            }
//        }
    }
    
    
    
}
