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
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let secondViewController = HomeViewController()
        self.present(secondViewController, animated: false, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        addTripToRealm()
        //Should do this
        //let secondViewController = AddTripActivitiesViewController()
        //but for now
        let secondViewController = AllTripsTableViewController()
        self.present(secondViewController, animated: false, completion: nil)
    }
    func addTripToRealm() {
        let newTrip = Trip()
        print(titleTextField.text!)
        newTrip.name = titleTextField.text!
        print(destinationTextField.text!)
        newTrip.destination = destinationTextField.text!
       // newTrip.traveler = travelerNameTextField.text!
       // newTrip.gender = genderTextField.text!
        //newTrip.startDate =
        //newTRip.endDate =
        try! realm.write{
                realm.add(newTrip)
        }
    }
    


}
