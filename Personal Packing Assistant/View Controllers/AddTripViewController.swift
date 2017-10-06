//
//  AddTripViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class AddTripViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBOutlet weak var travelerNameTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    init() {
        
        super.init(nibName: String(describing: AddTripViewController.self), bundle: Bundle.main)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
