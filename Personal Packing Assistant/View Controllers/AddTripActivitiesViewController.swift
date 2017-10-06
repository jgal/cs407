//
//  AddTripActivitiesViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class AddTripActivitiesViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    
    init() {
        
        super.init(nibName: String(describing: AddTripActivitiesViewController.self), bundle: Bundle.main)

        
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
    
    @IBAction func backButtonTapped(sender: UIButton) {
        let nextViewController = AddTripViewController()
        self.present(nextViewController, animated: false, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        let nextViewController = PackingListViewController()
        self.present(nextViewController, animated: false, completion: nil)
    }
    
}
