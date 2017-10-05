//
//  AddTripViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import UIKit

class AddTripViewController : UIViewController {
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var startDateTextBox: UITextField!
    @IBOutlet weak var endDateTextBox: UITextField!
    @IBOutlet weak var destinationTextBox: UITextField!
    @IBOutlet weak var travelerNameTextBox: UITextField!
    @IBOutlet weak var genderTextBox: UITextField!
    
    init() {
        super.init(nibName: String(describing: AddTripViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
}

