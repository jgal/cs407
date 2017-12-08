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
import LUAutocompleteView
import MapKit

class AddTripViewController: UIViewController, UITextFieldDelegate  {
    let autocompleteView = LUAutocompleteView()
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    let blueColor = UIColor(red: 60/255, green: 155/255, blue: 175/255, alpha: 1.0)
    let greyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)

    
    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var startDateTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var endDateTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var destinationTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var travelerNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var genderSelector: UISegmentedControl!
    
    var startDate: Date? = nil
    var endDate: Date? = nil
    
    var datePicker : UIDatePicker!
    
    let fromHome: Bool

    let existingTrip: Trip?
    var currentTrip: Trip
    
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
        // change label colors
        
        // title
        titleTextField.tintColor = blueColor
        titleTextField.lineColor = greyColor
        titleTextField.selectedTitleColor = blueColor
        titleTextField.selectedLineColor = blueColor
        
        // start date
        startDateTextField.tintColor = blueColor
        startDateTextField.lineColor = greyColor
        startDateTextField.selectedTitleColor = blueColor
        startDateTextField.selectedLineColor = blueColor
        
        // end date
        endDateTextField.tintColor = blueColor
        endDateTextField.lineColor = greyColor
        endDateTextField.selectedTitleColor = blueColor
        endDateTextField.selectedLineColor = blueColor
        
        // destination
        destinationTextField.tintColor = blueColor
        destinationTextField.lineColor = greyColor
        destinationTextField.selectedTitleColor = blueColor
        destinationTextField.selectedLineColor = blueColor
        
        // traveler
        travelerNameTextField.tintColor = blueColor
        travelerNameTextField.lineColor = greyColor
        travelerNameTextField.selectedTitleColor = blueColor
        travelerNameTextField.selectedLineColor = blueColor
        
        
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
        
        view.addSubview(autocompleteView)
        
        autocompleteView.textField = destinationTextField
        autocompleteView.dataSource = self
        autocompleteView.delegate = self
        searchCompleter.delegate = self
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
        let num = -1
        let secondViewController = AddTripActivityViewController(selectedTrip: currentTrip, fromDay: num)
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

        let t = self.existingTrip != nil ? self.existingTrip! : Trip()

        try! realm.write {
            
            t.name = self.titleTextField.text!
            t.destination = self.destinationTextField.text!
            t.traveler = self.travelerNameTextField.text!
            t.startDate = self.startDate
            t.endDate = self.endDate
            
            if let s = self.selectedCoordinates {
                let l = Location()
                l.latitude = s.latitude
                l.longitude = s.longitude
                
                realm.add(l)
                t.coordinates = l
            }
            else
            {
                t.coordinates = nil
            }
            
            var gender = ""
            if self.genderSelector.selectedSegmentIndex == 0 {
                gender = "Male"
            } else if self.genderSelector.selectedSegmentIndex == 1 {
                gender = "Female"
            } else {
                gender = "Other"
            }
            
            t.gender = gender
            
            t.days.removeAll()
            
            if self.existingTrip == nil {
                realm.add(t)
                self.currentTrip = t
            }
        }
        
        // Calculate the number of days
        let cal = Calendar.current

        var thisDate: Date = startDate!
        var days = [Day(thisDate)]
        
        let dispatchGroup = DispatchGroup()
        
        repeat {
            thisDate = cal.date(byAdding: .day,
                                value: 1,
                                to: thisDate)!
            
            let d = Day(thisDate)
            days.append(d)
        } while(thisDate < endDate!)
        
        for d in days {
            dispatchGroup.enter()
            
            WeatherService.sharedInstance.getHistoricalWeather(forDay: d, inTrip: t, complete: { (err, weather) in
                if let w = weather {
                    d.weather = w
                }
                
                if let e = err {
                    print(e)
                }
                
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global(qos: .userInitiated)) {
            DispatchQueue.main.async {
                try! realm.write {
                    for d in days {
                        if let w = d.weather {
                            realm.add(w)
                        }
                        
                        realm.add(d)
                    }
                    
                    t.days.append(objectsIn: days)
                    
                    print("done with weather and days")
                }
            }
        }
    }
    
    var autocompleteCompletion: (([String]) -> Void)!
    
    var selectedSearchResult: MKLocalSearchCompletion? = nil
    var selectedCoordinates: CLLocationCoordinate2D? = nil
}

// MARK: - LUAutocompleteViewDataSource

extension AddTripViewController: LUAutocompleteViewDataSource {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, elementsFor text: String, completion: @escaping ([String]) -> Void) {
        autocompleteCompletion = completion

        searchCompleter.queryFragment = text
    }
}

// MARK: - LUAutocompleteViewDelegate

extension AddTripViewController: LUAutocompleteViewDelegate {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, didSelect text: String) {
        autocompleteView.textField?.text = text
        
        let parts = text.components(separatedBy: "\n")
        
        selectedSearchResult = nil
        
        if let first = searchResults.filter({ $0.title == parts[0] && $0.subtitle == parts[1] }).first {
            selectedSearchResult = first
            
            let searchRequest = MKLocalSearchRequest(completion: first)
            let search = MKLocalSearch(request: searchRequest)
            search.start { (response, error) in
                self.selectedCoordinates = response?.mapItems[0].placemark.coordinate
            }
        }
    }
}

extension AddTripViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        
        autocompleteCompletion(searchResults.map { $0.title + "\n" + $0.subtitle })
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

final class LocationAutocompleteTableViewCell: LUAutocompleteTableViewCell {
    // MARK: - Base Class Overrides
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func set(text: String) {
        let parts = text.components(separatedBy: "\n")
        
        textLabel?.text = parts[0]
        detailTextLabel?.text = parts[1]
    }
}
