//
//  TripOverViewViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class TripOverViewViewController: UIViewController {
    @IBOutlet weak var tripTable: UITableView!
    
    var lists : Results<Trip>!
    
    init() {
        print("init")
        super.init(nibName: String(describing: TripOverViewViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("fatal Error")
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
    
    override func viewWillAppear(_ animated: Bool) {
        readTripsAndUpdateUI()
    }
    
    func readTripsAndUpdateUI(){
        
        lists = realm.objects(Trip.self)
        self.tripTable.setEditing(false, animated: true)
        self.tripTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let listsTasks = lists{
            return listsTasks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tripTable.dequeueReusableCell(withIdentifier: "listCell")
        
        let list = lists[indexPath.row]
        
        cell?.textLabel?.text = list.name
        cell?.detailTextLabel?.text = "\(list.name.count) Trips"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            
            let TripToBeDeleted = self.lists[indexPath.row]
            try! realm.write{
                
                realm.delete(TripToBeDeleted)
                self.readTripsAndUpdateUI()
            }
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit") { (editAction, indexPath) -> Void in
            
            // Editing will go here
            let TripToBeUpdated = self.lists[indexPath.row]
            //self.displayAlertToAddTRip(TripToBeUpdated)
        }
        return [deleteAction, editAction]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "Trips", sender: self.lists[indexPath.row])
    }
    

    

}
