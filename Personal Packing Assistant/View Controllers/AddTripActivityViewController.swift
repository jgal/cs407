//
//  AddTripActivityViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/1/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class AddTripActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    var currentTrip: Trip
    var activities : Results<Activity>!
    private var customView = UIView()
    @IBOutlet weak var activitiesTable: UITableView!
    
    public init(selectedTrip: Trip) {
        currentTrip = selectedTrip
        super.init(nibName: String(describing: AddTripActivityViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.isHidden = true
        title = "Add Activity"
        
        let buttonTitle = "Next"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        //navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.activitiesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        activitiesTable.delegate = self
        activitiesTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readTasksAndUpdateUI()
        print("viewWillAppear")
    }
    
    func readTasksAndUpdateUI() {
        self.activities = realm.objects(Activity.self)
        currentTrip = realm.objects(Trip.self).filter("name = %@", currentTrip.name).first!
        self.activitiesTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return activities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.activitiesTable.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        if ( indexPath.row < activities.count ) {
        //currentTrip.activities[i]
        let tripactivities = currentTrip.activities
        for object in tripactivities {
            if ( object.name == self.activities[indexPath.row].name) {
                cell.textLabel?.text = "\(self.activities[indexPath.row].icon) -  \(self.activities[indexPath.row].name) "
                cell.tintColor = UIColor.green
                cell.accessoryType = .checkmark
                cell.textLabel?.textAlignment = .left
                return cell
            }
        
        
        }
      
        cell.textLabel?.text = "\(self.activities[indexPath.row].icon) -  \(self.activities[indexPath.row].name) "
        cell.accessoryType = .none
             cell.textLabel?.textAlignment = .left
        } else {
            cell.textLabel?.text = "+"
            cell.textLabel?.textAlignment = .center
             cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if (indexPath.row < activities.count) {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            
            let activityToBeDeleted = self.activities[indexPath.row]
            var count = 0
            for object in self.currentTrip.activities {
                count = count + 1
                if object.name == self.activities[indexPath.row].name {
                    break
                }
            }
            try! realm.write{
                if count > 0 {
                realm.objects(Trip.self).filter("name = %@", self.currentTrip.name).first?.activities.remove(objectAtIndex: count-1)
                }
                realm.delete(activityToBeDeleted)
                
            }
            self.readTasksAndUpdateUI()
            
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit") { (editAction, indexPath) -> Void in
            let t = self.activities[indexPath.row]
            // modify popu
            self.loadEditCustomViewIntoController(activity: t)
            self.readTasksAndUpdateUI()
        }
        
        return [deleteAction, editAction]
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //currentTrip.activities.append(self.activities[indexPath.row])
        if (indexPath.row < activities.count) {
        let trip = realm.objects(Trip.self).filter("name = %@", currentTrip.name).first
        let tripactivities = trip?.activities
        var flag = -1
        var count = 0
        for object in tripactivities! {
            count = count + 1
            if object.name == activities[indexPath.row].name {
                flag = count
            }
        }
        if ( flag == -1) {
            try! realm.write {
                trip?.activities.append(self.activities[indexPath.row])
            }
        } else {
            try! realm.write {
                trip?.activities.remove(objectAtIndex: flag-1)
            }
        }
        readTasksAndUpdateUI()
        } else {
            print("\there")
            loadAddCustomViewIntoController()
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        addActivityToRealm()
        
        let alltripsVC = AllTripsTableViewController()
        let secondViewController = TripOverviewViewController(withExistingTrip: currentTrip )
        
        var vcs = [
            navigationController?.viewControllers[0],
            alltripsVC,
            secondViewController
        ]
        
        navigationController?.setViewControllers(vcs as! [UIViewController], animated: true)
    }
    
    
    private func loadEditCustomViewIntoController(activity: Activity ) {
        let alertController = UIAlertController(title: "Create Activity", message: "A standard alert", preferredStyle: .alert)
        alertController.addTextField { (textField) -> Void in
            // Enter the textfiled customization code here.
            let ActivityNameField = textField
            
            ActivityNameField.text = activity.name
            ActivityNameField.keyboardType  = .default
            ActivityNameField.keyboardAppearance = .default
        }
        alertController.addTextField { (textField) -> Void in
            // Enter the textfiled customization code here.
            let IconField = textField
            
            IconField.text = activity.icon
            
            IconField.keyboardType = .default
             IconField.keyboardAppearance = .default
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
        }
        
        
        let OKAction = UIAlertAction(title: "Add Activity", style: .default) { (action:UIAlertAction!) in
            //let o = realm.objects(Trip.self).filter("name = %@", currentTrip.name).first?.activities
            //let o1 = o?.filter("name = %@", activities.name)
            let a = Activity()
            a.name = alertController.textFields![0].text!
            a.icon = alertController.textFields![1].text!
            try! realm.write {
                    realm.delete(activity)
                realm.objects(Trip.self).filter("name = %@", self.currentTrip.name).first?.activities.append(a)
            }
            self.readTasksAndUpdateUI()
        }
        
        
        
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    private func loadAddCustomViewIntoController() {

        
        let alertController = UIAlertController(title: "Create Activity", message: "A standard alert", preferredStyle: .alert)
        alertController.addTextField { (textField) -> Void in
            // Enter the textfiled customization code here.
            let ActivityNameField = textField
            
            ActivityNameField.placeholder = "Enter Activity Name"
            
            ActivityNameField.keyboardType  = .default
            ActivityNameField.keyboardAppearance = .default
        }
        alertController.addTextField { (textField) -> Void in
            // Enter the textfiled customization code here.
            let IconField = textField
            
            IconField.placeholder = "Enter Activity Icon"
            IconField.keyboardType = .default
             IconField.keyboardAppearance = .default
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
        }
        
        
        let OKAction = UIAlertAction(title: "Add Activity", style: .default) { (action:UIAlertAction!) in
            let a = Activity()
            a.name = alertController.textFields![0].text!
            a.icon = alertController.textFields![1].text!
            try! realm.write {
                self.currentTrip.activities.append(a)
            }
            self.readTasksAndUpdateUI()
        }
        
        
        
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    func addActivityToRealm() {
        // add activities to Trip
        /*try! realm.write {
                realm.add()
        }*/
    }
    

   

}
