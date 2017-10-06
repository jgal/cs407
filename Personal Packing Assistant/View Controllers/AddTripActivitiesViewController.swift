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

    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
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
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        let secondViewController = AddTripViewController()
        self.present(secondViewController, animated: false, completion: nil)
    }
}
