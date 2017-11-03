//
//  TripOverviewViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/1/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class TripOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var add: UIBarButtonItem!
    
    @IBOutlet weak var table: UITableView!
    let tripName: String
    var trip : Trip!
    public init(withExistingTrip: Trip ) {
        tripName = withExistingTrip.name
        super.init(nibName: String(describing: TripOverviewViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readTripsAndUpdateUI()
        title = "\(trip.name) Overview"
        
        // let buttonTitle = "🗒"
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        //navigationItem.leftBarButtonItem?.isEnabled = false
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.delegate = self
        table.dataSource = self
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //readTripsAndUpdateUI()
    }

     func readTripsAndUpdateUI(){
        trip = realm.objects(Trip.self).filter("name = %@", tripName).first
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        print("hereere")
        if ( section == 0) {
                return "List of Days"
        } else if ( section == 1) {
                return "List of Activities"
        } else if ( section == 2) {
                return "List of Outfits"
        } else {
                return "Default"
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch ( section  ) {
        case 0:
            return self.trip.days.count
        case 1:
            return self.trip.activities.count
        case 2:
            return self.trip.outfits.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print("tableView 2")
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.table.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMMM d, yyy"
        
        // set the text from the data model
        if ( indexPath.section == 0) {
            cell.textLabel?.text = "Day \(indexPath.row+1): \(formatter.string(from:trip.days[indexPath.row].date))"
        } else if ( indexPath.section == 1) {
            cell.textLabel?.text = "\(trip.activities[indexPath.row].name)"
        } else if ( indexPath.section == 2) {
            cell.textLabel?.text = "\(trip.outfits[indexPath.row].name)"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    @objc func nextButtonTapped(_ sender: UIButton) {
         let secondViewController = AllTripsTableViewController()
         navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func AddObject(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        // 2
        let OutfitAction = UIAlertAction(title: "Outfit", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Add Outfit")
            let secondViewController = AddOutfitViewController(withExistingTrip: self.trip)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        let TripItemAction = UIAlertAction(title: "TripItem", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Add TripItem")
            let secondViewController = AddTripItemViewController(withExistingTrip: self.trip)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        
        //
        let ActivityAction = UIAlertAction(title: "Activity", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Add Activity")
            let secondViewController = AddTripActivityViewController(selectedTrip: self.trip)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        let ItemAction = UIAlertAction(title: "Item", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Add Item")
            let secondViewController = AddItemViewController(withExistingTrip: self.trip, withItemToEdit: nil)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenu.addAction(ItemAction)
        optionMenu.addAction(TripItemAction)
        optionMenu.addAction(ActivityAction)
        optionMenu.addAction(OutfitAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    @IBAction func showPackinglist(_ sender: Any) {
        let secondViewController = PackingListViewController(withExistingTrip: self.trip)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}
