//
//  HomeViewController.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController : UIViewController {
    
    @IBOutlet weak var planNewTripButton: UIButton!
    @IBOutlet weak var viewAllTripsButton: UIButton!
    
    init() {
        super.init(nibName: String(describing: HomeViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @IBAction func planNewTripTapped(sender: AnyObject) {
        self.navigationController?.pushViewController(AddTripViewController(), animated: true)
    }
}

