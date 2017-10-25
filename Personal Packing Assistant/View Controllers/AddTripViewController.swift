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
    
    init() {
        super.init(nibName: String(describing: AddTripViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Add Trip"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
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
        //Should do this
        //let secondViewController = AddTripActivitiesViewController()
        //but for now
        let secondViewController = AllTripsTableViewController()
        self.present(secondViewController, animated: false, completion: nil)
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
        let newTrip = Trip()
        print(titleTextField.text!)
        newTrip.name = titleTextField.text!
        print(destinationTextField.text!)
        newTrip.destination = destinationTextField.text!
       // newTrip.traveler = travelerNameTextField.text!
       // newTrip.gender = genderTextField.text!
        newTrip.startDate = startDateTextField.text!
        newTrip.endDate = endDateTextField.text!
        try! realm.write{
                realm.add(newTrip)
        }
    }
    


}
