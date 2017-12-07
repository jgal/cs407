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
import Photos

class TripOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var add: UIBarButtonItem!
    
    @IBOutlet weak var table: UITableView!
    let tripName: String
    var trip : Trip!
    
    var outfits: List<Outfit>!
    var activities: List<Activity>!
    
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
        readTasksAndUpdateUI()
        title = "\(trip.name) Overview"
        
        // let buttonTitle = "🗒"
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        //navigationItem.leftBarButtonItem?.isEnabled = false
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 90
        table.delegate = self
        table.dataSource = self
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //readTasksAndUpdateUI()
    }

     func readTasksAndUpdateUI(){
        trip = realm.objects(Trip.self).filter("name = %@", tripName).first
        self.outfits = self.trip.outfits
        self.activities = self.trip.activities

       
        self.table.setEditing(false, animated: true)
        print("before reload")
        self.table.reloadData()
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
        let attributes = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15),
                           NSAttributedStringKey.foregroundColor: UIColor.darkGray ]
        let attributesTitle = [ NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17),
                                NSAttributedStringKey.foregroundColor: UIColor.black ]
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMMM d, yyy"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "d"
        // set the text from the data model
        let weather = ["⛅️","❄️","🌨","🌩","⛈","☁️","🌦","☀️"]
        if ( indexPath.section == 0) {
            //cell.imageView?.image = trip.days[indexPath.row].weather.icon.image()
            let myInt = Int(formatter2.string(from:trip.days[indexPath.row].date))
            cell.imageView?.image = weather[(myInt)!%8].image()
            
            let formattedString = NSMutableAttributedString(string: "Day \(indexPath.row+1): \(formatter.string(from:trip.days[indexPath.row].date))\n", attributes: attributesTitle)
            
            formattedString.append(NSAttributedString(string: "Activities: \(trip.days[indexPath.row].activities.count) \nOutfits: \(trip.days[indexPath.row].outfits.count) ", attributes: attributes))
            cell.textLabel?.attributedText = formattedString
            cell.textLabel?.numberOfLines = 3
            //cell.
            let btn: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            btn.backgroundColor = UIColor.clear
            btn.setTitle("🆕", for: .normal)
            btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            //cell.accessoryView?.addSubview( btn)
            cell.accessoryView = btn
        } else if ( indexPath.section == 1) {
            cell.imageView?.image = trip.activities[indexPath.row].icon.image()
            let formattedString = NSMutableAttributedString(string: "\(trip.activities[indexPath.row].name)", attributes: attributesTitle)
            cell.textLabel?.attributedText = formattedString
        } else if ( indexPath.section == 2) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.fetchLimit = 1
            
            var lastImageAsset: PHAsset? = nil
            //lastImageAsset.
            let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            if (fetchResult.firstObject != nil)
            {
                lastImageAsset = fetchResult.firstObject as! PHAsset
                
            }
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            if ( lastImageAsset != nil) {
            manager.requestImage(for: lastImageAsset!, targetSize: CGSize(width: 40, height: 40), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
        }
            cell.imageView?.image = thumbnail
            cell.textLabel?.text = "\(trip.outfits[indexPath.row].name)"
            
        }
        
        cell.accessoryType = .none
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if ( indexPath.section == 1 ) {
            
            
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
                
                //Deletion will go here
                let activityToBeDeleted = self.activities[indexPath.row]
                try! realm.write{
                    self.trip.activities.remove(objectAtIndex: indexPath.row)
                    self.readTasksAndUpdateUI()
                }
            }
            let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit") { (editAction, indexPath) -> Void in
                let t = self.trip
                let vc = AddTripActivityViewController(selectedTrip: t!)
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return [deleteAction, editAction]
        }
        else if ( indexPath.section == 2 ) {
            
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            let outfitToBeDeleted = self.outfits[indexPath.row]
            try! realm.write{
                //self.items.remove(objectAtIndex: indexPath.row)
                //realm.delete(itemToBeDeleted)
                self.trip.outfits.remove(objectAtIndex: indexPath.row)
                self.readTasksAndUpdateUI()
            }
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit") { (editAction, indexPath) -> Void in
            let t = self.outfits[indexPath.row]
            let vc = AddOutfitViewController(withExistingTrip: self.trip, withOutfitToEdit: t, index: indexPath.row)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return [deleteAction, editAction]
        }
        return []
    }
    
     @objc func buttonAction(sender: UIButton!) {
        
        
    
 
        
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
            let secondViewController = AddOutfitViewController(withExistingTrip: self.trip, withOutfitToEdit: nil, index: -1)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        let ActivityAction = UIAlertAction(title: "Activity", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Add Activity")
            let secondViewController = AddTripActivityViewController(selectedTrip: self.trip)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        let ItemAction = UIAlertAction(title: "Item", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Add Item")
            let secondViewController = AddItemViewController(withExistingTrip: self.trip, withItemToEdit: nil, index: -1)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenu.addAction(ItemAction)
        optionMenu.addAction(ActivityAction)
        optionMenu.addAction(OutfitAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected")
        if (indexPath.section == 0) {
            let secondViewController = DayOverviewViewController(withExistingTrip: self.trip, selectedDay: self.trip.days[indexPath.row])
            navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    @IBAction func showPackinglist(_ sender: Any) {
        let secondViewController = PackingListViewController(withExistingTrip: self.trip)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}
