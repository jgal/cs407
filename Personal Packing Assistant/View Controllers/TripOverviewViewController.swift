//
//  TripOverviewViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import UIKit

class TripOverviewViewController : UIViewController {
    
    @IBOutlet weak var packingListButton: UINavigationBar!
    @IBOutlet weak var homeButton: UINavigationBar!
    
    
    
    init() {
        super.init(nibName: String(describing: TripOverviewViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
