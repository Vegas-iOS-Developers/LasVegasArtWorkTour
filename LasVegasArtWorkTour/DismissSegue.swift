//
//  DismissSegue.swift
//  LasVegasArtWorkTour
//
//  Created by Joel Bell on 11/12/16.
//  Copyright © 2016 ROKIBI. All rights reserved.
//

import Foundation
import UIKit

class DismissSegue: UIStoryboardSegue {
    override func perform() {
        self.source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
