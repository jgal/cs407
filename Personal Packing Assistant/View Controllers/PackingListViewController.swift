//
//  PackingListViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import RealmSwift
import Foundation
import UIKit

class PackingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var packingListTable: UITableView!
    var assignedTrip: Trip
    var items: [Item] = []

    init(withExistingTrip: Trip!) {
        assignedTrip = withExistingTrip
        
        super.init(nibName: String(describing: PackingListViewController.self), bundle: Bundle.main)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Packing List"
        // Do any additional setup after loading the view.
        self.packingListTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddItemButtonTapped(_:)))
        
        packingListTable.delegate = self
        packingListTable.dataSource = self
        
        
        let item1 = Item()
        item1.name = "passport"
        items.append(item1)
        
        let item2 = Item()
        item2.name = "towel"
        items.append(item2)
        
        let item3 = Item()
        item3.name = "coat"
        items.append(item3)

        
    }
    
    func readTasksAndUpdateUI() {
        //self.items = realm.objects(Items)
        
        for element in items {
            print(element.name)
        }
        self.packingListTable.setEditing(false, animated: true)
        print("before reload")
        self.packingListTable.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.packingListTable.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.items[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            let itemToBeDeleted = self.items[indexPath.row]
            self.items.remove(at: indexPath.row)
            self.readTasksAndUpdateUI()
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit") { (editAction, indexPath) -> Void in
            let t = self.items[indexPath.row]
            let vc = AddItemViewController(withExistingTrip: self.assignedTrip, withItemToEdit: t)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return [deleteAction, editAction]
    }
    
    @objc func AddItemButtonTapped(_ sender: UIBarButtonItem) {
        let secondViewController = AddItemViewController(withExistingTrip: self.assignedTrip, withItemToEdit: nil)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
