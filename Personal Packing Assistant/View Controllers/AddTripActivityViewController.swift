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
    
    
    var DayNum: Int
    var currentTrip: Trip
    var activities : Results<Activity>!
    var filteredActivities : List<Activity>!
    private var customView = UIView()
    @IBOutlet weak var activitiesTable: UITableView!
    
    public init(selectedTrip: Trip, fromDay: Int) {
        currentTrip = selectedTrip
        DayNum = fromDay
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
        if ( DayNum != -1) {
            self.filteredActivities = currentTrip.activities
        }
        self.activitiesTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( DayNum != -1) {
            return self.filteredActivities.count
        }
        return activities.count // + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.activitiesTable.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        //currentTrip.activities[i]
        let tripactivities : List<Activity>
        if ( DayNum != -1) {
            tripactivities = currentTrip.days[DayNum].activities
            for object in tripactivities {
                if ( object.name == self.filteredActivities[indexPath.row].name) {
                    cell.textLabel?.text = "\(self.filteredActivities[indexPath.row].icon) -  \(self.filteredActivities[indexPath.row].name) "
                    cell.tintColor = UIColor.green
                    cell.accessoryType = .checkmark
                    cell.textLabel?.textAlignment = .left
                    return cell
                }
            }
            cell.textLabel?.text = "\(self.filteredActivities[indexPath.row].icon) -  \(self.filteredActivities[indexPath.row].name) "
            cell.accessoryType = .none
            cell.textLabel?.textAlignment = .left
            return cell
        } else {
            tripactivities = currentTrip.activities
       
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
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return []
        
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
        if ( DayNum == -1) {
            let tripactivities = currentTrip.activities
            var flag = -1
            var count = 0
            for object in tripactivities {
                count = count + 1
                if object.name == activities[indexPath.row].name {
                    flag = count
                }
            }
           try! realm.write {
                if ( flag == -1) {
                    currentTrip.activities.append(self.activities[indexPath.row])
                } else {
                    currentTrip.activities.remove(objectAtIndex: flag-1)
                }
            }
            readTasksAndUpdateUI()
        } else {
            let tripactivities = currentTrip.days[self.DayNum].activities
            var flag = -1
            var count = 0
            for object in tripactivities {
                count = count + 1
                if object.name == self.filteredActivities[indexPath.row].name {
                    flag = count
                    break
                }
            }
            try! realm.write {
                if ( flag == -1) {
                    currentTrip.days[self.DayNum].activities.append(self.filteredActivities[indexPath.row])
                } else {
                    currentTrip.days[self.DayNum].activities.remove(objectAtIndex: flag-1)
                }
            }
            readTasksAndUpdateUI()
            
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        addActivityToRealm()
        if ( self.DayNum == -1) {
            let packingListGenerator = PackingListGenerator(trip: currentTrip)
            let items = packingListGenerator.makeListOfTripItems()
            
            try! realm.write {
                for i in items {
                    var itemThatExists = realm.objects(TripItem.self).filter("name = %@", i.name).first
                    
                    if itemThatExists == nil {
                        realm.add(i)
                    }
                    itemThatExists = currentTrip.tripItems.filter("name = %@", i.name).first
                    if itemThatExists == nil {
                        currentTrip.tripItems.append(i)
                        
                    }
                    
                }
            }
        
            let alltripsVC = AllTripsTableViewController()
            let secondViewController = TripOverviewViewController(withExistingTrip: currentTrip)
            
            let vcs = [
                navigationController?.viewControllers[0],
                alltripsVC,
                secondViewController
            ]
            navigationController?.setViewControllers(vcs as! [UIViewController], animated: true)
        } else {
            print("just")
            let alltripsVC = TripOverviewViewController(withExistingTrip: self.currentTrip)
             print("before")
            let secondViewController = DayOverviewViewController(withExistingTrip: self.currentTrip, indexPathRow: self.DayNum)
             print("DayOverview")
            let vcs = [
                navigationController?.viewControllers[0],
                alltripsVC,
                secondViewController
            ]
            print("just before DayOverview")
            navigationController?.setViewControllers(vcs as! [UIViewController], animated: true)
        }
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
