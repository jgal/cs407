//
//  AllTripsTableViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class AllTripsTableViewController: UIViewController {

    init() {
        super.init(nibName: String(describing: AllTripsTableViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddTripButtonTapped(_ sender: UIBarButtonItem) {
        let secondViewController = AddTripViewController()
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        let secondViewController = HomeViewController()
        self.present(secondViewController, animated: false, completion: nil)
        
    }
    
}
