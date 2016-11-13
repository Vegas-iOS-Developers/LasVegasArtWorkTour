//
//  ArtworkCell.swift
//  LasVegasArtWorkTour
//
//  Created by Joel Bell on 11/12/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import UIKit

class ArtworkCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
