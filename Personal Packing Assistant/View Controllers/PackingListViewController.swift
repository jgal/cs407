//
//  PackingListViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift

class PackingListViewController : UIViewController {
    
    init() {
        super.init(nibName: String(describing: PackingListViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
