//
//  AllTripsTableViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class AllTripsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var lists : Results<Trip>!
    @IBOutlet weak var tripTable: UITableView!

    init() {
        super.init(nibName: String(describing: AllTripsTableViewController.self), bundle: Bundle.main)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tripTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tripTable.delegate = self
        tripTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readTasksAndUpdateUI()
        print("viewWillAppear")
    }
    
    func readTasksAndUpdateUI() {
        self.lists = realm.objects(Trip.self)
        
        //let trips = try! Realm().objects(Trip.self)
        for element in lists {
            print(element.name)
        }
        self.tripTable.setEditing(false, animated: true)
        print("before reload")
        self.tripTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView 1")
        
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print("tableView 2")
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tripTable.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.lists[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
    
            //Deletion will go here
            let tripToBeDeleted = self.lists[indexPath.row]
            try! realm.write{
                realm.delete(tripToBeDeleted)
                self.readTasksAndUpdateUI()
            }
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit") { (editAction, indexPath) -> Void in
    
            // Editing will go here
    
        }
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView 4")
        print("jb \(self.lists[indexPath.row]) " )
        
    }
    
    
   
    @IBAction func AddTripButtonTapped(_ sender: UIBarButtonItem) {
        let secondViewController = AddTripViewController()
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        let secondViewController = HomeViewController()
        self.present(secondViewController, animated: false, completion: nil)
        
    }
    
}
