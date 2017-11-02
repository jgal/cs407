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
import SkyFloatingLabelTextField

class AddTripViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBOutlet weak var travelerNameTextField: UITextField!
    
    @IBOutlet weak var genderSelector: UISegmentedControl!
    
    var startDate: Date? = nil
    var endDate: Date? = nil
    
    var datePicker : UIDatePicker!
    
    let fromHome: Bool

    let existingTrip: Trip?
    var curentTrip: Trip
    public init(fromHome: Bool = false, withExistingTrip: Trip? = nil) {
        self.fromHome = fromHome
        existingTrip = withExistingTrip
        if ( existingTrip != nil) {
            curentTrip = withExistingTrip!
        } else {
            curentTrip = Trip()
        }
        super.init(nibName: String(describing: AddTripViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Add Trip"
        
        let buttonTitle = existingTrip == nil ? "Next" : "Save"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        if let t = existingTrip {
            titleTextField.text = t.name
            destinationTextField.text = t.destination
            travelerNameTextField.text = t.traveler
            
            startDate = t.startDate
            endDate = t.endDate
            
            let df = DateFormatter()
            df.dateStyle = .medium
            df.timeStyle = .none
            
            startDateTextField.text = df.string(from: startDate!)
            endDateTextField.text = df.string(from: endDate!)
            
            if t.gender == "Male" {
                genderSelector.selectedSegmentIndex = 0
            }
            else if t.gender == "Female" {
                genderSelector.selectedSegmentIndex = 1
            }
            else {
                genderSelector.selectedSegmentIndex = 2
            }
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldIsBeingEdited(_ sender: Any) {
        self.pickUpDate(self.startDateTextField)
    }
    @IBAction func EndDateEditing(_ sender: Any) {
        self.pickUpDate(self.endDateTextField)
    }
    
    //MARK:- Function of datePicker
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        if textField == startDateTextField {
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddTripViewController.doneClick))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddTripViewController.cancelClick))
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        } else {
            if let d = startDate {
                datePicker.date = d
                datePicker.minimumDate = d
            }
            
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddTripViewController.done1Click))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddTripViewController.cancel1Click))
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        }
        
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // MARK:- Button Done and Cancel
    @objc func doneClick(_ textField : UITextField) {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        startDateTextField.text = dateFormatter1.string(from: datePicker.date)
        startDateTextField.resignFirstResponder()
        
        startDate = datePicker.date
    }
    @objc func cancelClick(_ textField : UITextField) {
        startDateTextField.resignFirstResponder()
    }
    @objc func done1Click(_ textField : UITextField) {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        endDateTextField.text = dateFormatter1.string(from: datePicker.date)
        endDateTextField.resignFirstResponder()
        
        endDate = datePicker.date
    }
    @objc func cancel1Click(_ textField : UITextField) {
        endDateTextField.resignFirstResponder()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        addTripToRealm()
        //let secondViewController = AllTripsTableViewController()
        let secondViewController = AddTripActivityViewController(selectedTrip: curentTrip)
        //navigationController?.popViewController(animated: false)

       // if fromHome {
            // Change to navigate to the AddTripActivitiesViewController once it is created
            navigationController?.pushViewController(secondViewController, animated: true)
       // }
        
    }
    @IBAction func checkValidation(_ sender: SkyFloatingLabelTextField) {
        var enabled = true
        if titleTextField.text?.count == 0 {
            enabled = false
        } else if startDateTextField.text?.count == 0 {
            enabled = false
        } else if endDateTextField.text?.count == 0 {
            enabled = false
        } else if destinationTextField.text?.count == 0 {
            enabled = false
        } else if travelerNameTextField.text?.count == 0 {
            enabled = false
        }
        navigationItem.rightBarButtonItem?.isEnabled = enabled
    }
    func addTripToRealm() {
        try! realm.write {
            let t = existingTrip != nil ? existingTrip! : Trip()
            
            print(titleTextField.text!)
            t.name = titleTextField.text!
            print(destinationTextField.text!)
            t.destination = destinationTextField.text!
            t.traveler = travelerNameTextField.text!
            t.startDate = startDate
            t.endDate = endDate
            var gender = ""
            if genderSelector.selectedSegmentIndex == 0 {
                gender = "Male"
            } else if genderSelector.selectedSegmentIndex == 1 {
                gender = "Female"
            } else {
                gender = "Other"
            }
            t.gender = gender
            
            // Calculate the number of days
            let cal = Calendar.current
            
            var thisDate: Date = startDate!
            
            repeat {
                thisDate = cal.date(byAdding: .day,
                                    value: 1,
                                    to: thisDate,
                                    wrappingComponents: true)!
                
                t.days.append(Day(thisDate))
            } while(thisDate < endDate!)
            
            if existingTrip == nil {
                realm.add(t)
                curentTrip = t
            }
        }
    }
}
