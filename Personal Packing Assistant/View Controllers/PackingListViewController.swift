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
import CheckboxButton

class PackingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var packingListTable: UITableView!
    let assignedTrip: Trip
    //var items: [TripItem]!
    var items: Results<TripItem>!
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
        packingListTable.rowHeight = UITableViewAutomaticDimension
        packingListTable.estimatedRowHeight = 44
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddItemButtonTapped(_:)))
        
        packingListTable.delegate = self
        packingListTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readTasksAndUpdateUI()
    }
    
    func readTasksAndUpdateUI() {
       // self.items = self.assignedTrip.tripItems.sorted(byKeyPath: "name", ascending: true)

       // self.items = self.assignedTrip.tripItems.sorted(by: { (a, b) -> Bool in
            // sort alphabetically
       //     return a.name < b.name
        //})
        
        self.items = self.assignedTrip.tripItems.sorted(byKeyPath: "name")
        
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
       // let cell:UITableViewCell = self.packingListTable.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        var b = self.packingListTable.dequeueReusableCell(withIdentifier: "subtitle")
        
        if b == nil {
            b = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
        }
        
        let cell = b!
        
        // set the text from the data model
        let item = self.items[indexPath.row]
        
        cell.textLabel?.text = String(item.quantity) + " \t" + item.name
        cell.detailTextLabel?.text = nil
        //cell.detailTextLabel?.numberOfLines = 0
        
        let c = CheckboxButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        c.tag = indexPath.row
        
        c.removeTarget(nil, action: nil, for: .allEvents)
        c.addTarget(self, action: #selector(toggleCheckbox), for: .valueChanged)
        
        c.on = item.packed
        
        
        cell.selectionStyle = .none
        cell.accessoryView = c
        return cell
    }
    
    @objc func toggleCheckbox(sender: CheckboxButton) {
        try! realm.write {
            let item = self.items[sender.tag]
            
            item.packed = true
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
            let t = self.items[indexPath.row]
            print("delete  \(t.name)")
            var count = 0
            var number = -1
            for item in self.assignedTrip.tripItems {
                if (item.name ==  t.name) {
                    number = count;
                    break
                }
                count += 1;
            }
            if ( number != -1 ) {
            //Deletion from list in realm
            try! realm.write{
                self.assignedTrip.tripItems.remove(objectAtIndex: number)
                self.readTasksAndUpdateUI()
            }
            }
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit") { (editAction, indexPath) -> Void in
            let t = self.items[indexPath.row]
            let vc = AddItemViewController(withExistingTrip: self.assignedTrip, withItemToEdit: t, index: indexPath.row)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return [deleteAction, editAction]
    }
    
    @objc func AddItemButtonTapped(_ sender: UIBarButtonItem) {
        let secondViewController = AddItemViewController(withExistingTrip: self.assignedTrip, withItemToEdit: nil, index: -1)
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
