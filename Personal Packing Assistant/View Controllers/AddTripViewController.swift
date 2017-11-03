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
    
    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    
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
    var currentTrip: Trip
    
    var maleList = ["shaving kit", "cologne"]
    var femaleList = ["hair ties", "feminine hygiene products", "perfume"]
    var neutralList = ["passport", "itinerary", "wallet", "toothbrush", "toothpaste", "toiletries", "deodorant", "cell phone", "charger", "camera", "undergarments", "umbrella/rain jacket", "brush", "prescription medication", "hand sanitizer", "headphones"]
    
    
    public init(fromHome: Bool = false, withExistingTrip: Trip? = nil) {
        self.fromHome = fromHome
        existingTrip = withExistingTrip
        if ( existingTrip != nil) {
            currentTrip = withExistingTrip!
        } else {
            currentTrip = Trip()
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
        
        checkValidation(titleTextField)
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
        
        checkValidation(titleTextField)
    }
    @objc func cancel1Click(_ textField : UITextField) {
        endDateTextField.resignFirstResponder()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        addTripToRealm()

        let secondViewController = AddTripActivityViewController(selectedTrip: currentTrip)
        navigationController?.pushViewController(secondViewController, animated: true)
       
        
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
        if realm.objects(Trip.self).filter("name = %@", titleTextField.text!).count > 0 {
            let alert = UIAlertController(title: "Invalid Input", message: "Trip name already exists", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            titleTextField.text = ""
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        try! realm.write {
            let t = existingTrip != nil ? existingTrip! : Trip()
            
            t.name = titleTextField.text!
            t.destination = destinationTextField.text!
            t.traveler = travelerNameTextField.text!
            t.startDate = startDate
            t.endDate = endDate
         
            var gender = ""
            if genderSelector.selectedSegmentIndex == 0 {
                gender = "Male"
                addToItemList(trip: t, list: self.maleList)
                addToItemList(trip: t, list: self.neutralList)
            } else if genderSelector.selectedSegmentIndex == 1 {
                gender = "Female"
                addToItemList(trip: t, list: self.femaleList)
                addToItemList(trip: t, list: self.neutralList)
            } else {
                gender = "Other"
                addToItemList(trip: t, list: self.neutralList)
            }
            t.gender = gender
            
            // Calculate the number of days
            let cal = Calendar.current
            
            var thisDate: Date = startDate!
            
            repeat {
                thisDate = cal.date(byAdding: .day,
                                    value: 1,
                                    to: thisDate)!
                
                t.days.append(Day(thisDate))
            } while(thisDate < endDate!)
            
            if existingTrip == nil {
                realm.add(t)
                currentTrip = t
            }
        }
    }
    
    func addToItemList(trip: Trip, list: [String]) {
        for itemName in list {
            let i = Item()
            i.name = itemName
            trip.items.append(i)
        }
    }
}
