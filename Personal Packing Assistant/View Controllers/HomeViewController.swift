//
//  HomeViewController.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class HomeViewController : UIViewController {
    
    @IBOutlet weak var planNewTripButton: UIButton!
    @IBOutlet weak var viewAllTripsButton: UIButton!
    
    init() {
        super.init(nibName: String(describing: HomeViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func planNewTripTapped(sender: Any) {
        
        print("planNewTripTapped: before push")
        let secondViewController = AddTripViewController()
        self.present(secondViewController, animated: true, completion: nil)
        print("planNewTripTapped: after push")

    }
    @IBAction func viewAllTripsTapped(_ sender: UIButton) {
        print("viewAllTripsTapped: before push")
        let secondViewController = AllTripsTableViewController()
        self.present(secondViewController, animated: true, completion: nil)
 
        
        print("viewAllTripsTapped: after push")
    }
}

