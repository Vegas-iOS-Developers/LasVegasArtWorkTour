//
//  ArtworkListViewController.swift
//  LasVegasArtWorkTour
//
//  Created by Joel Bell on 11/12/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import UIKit

fileprivate let dataURL = "https://opendata.lasvegasnevada.gov/resource/nefs-tayh.json"
fileprivate let cellIdentifier = "CellIdentifier"

class ArtworkListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    
    fileprivate lazy var dataService: DataService = {
        let dataService = DataService()
        return dataService
    }()
    
    var artworks = [Artwork]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.register(ArtworkCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.dataService.download(from: dataURL) { response in
            switch response {
            case .success(let value):
                self.artworks = ArtworkParser.parse(value)
                self.tableView?.reloadData()
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artworks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let artwork = self.artworks[indexPath.row]
        cell.textLabel?.text = artwork.name
        cell.detailTextLabel?.text = artwork.locationDesc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artwork = self.artworks[indexPath.row]
        self.performSegue(withIdentifier: "ArtworkDetailSegue", sender: artwork)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArtworkDetailSegue" {
            if let artwork = sender as? Artwork {
                if let detailVC = segue.destination as? ArtworkDetailViewController {
                    detailVC.artwork = artwork
                }
            }
        }
    }
}
