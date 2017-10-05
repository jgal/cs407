//
//  EditDayViewController.swift
//  Personal Packing Assistant
//
//  Created by Joyce Kao on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class EditDayViewController : UIViewController {
    
    init() {
        super.init(nibName: String(describing: EditDayViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
