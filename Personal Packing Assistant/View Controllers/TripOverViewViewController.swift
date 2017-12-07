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

        readTasksAndUpdateUI()
        
        title = trip.destination
        navigationItem.prompt = "\(trip.name) Overview"
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 44
        table.delegate = self
        table.dataSource = self
    }
    
    func readTasksAndUpdateUI(){
        trip = realm.objects(Trip.self).filter("name = %@", tripName).first
        self.outfits = self.trip.outfits
        self.activities = self.trip.activities
        
        
        self.table.setEditing(false, animated: true)
        self.table.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
        var c = self.table.dequeueReusableCell(withIdentifier: "subtitle")
        
        if c == nil {
            c = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
        }
        
        let cell = c!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMMM d, yyy"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "d"
        
        if (indexPath.section == 0) {
            let day = trip.days[indexPath.row]
            let weather = day.weather!
            
            cell.textLabel?.text = "\(weather.emoji)  Day \(indexPath.row+1): \(formatter.string(from: day.date))"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            
            cell.detailTextLabel?.text = "Low: \(String(format: "%.0f", weather.minTemp))℉  Hi: \(String(format: "%.0f", weather.maxTemp))℉.\n\(weather.weatherName)"
            cell.detailTextLabel?.numberOfLines = 0
            
            cell.accessoryType = .none
            cell.selectionStyle = .none
        }
        else if (indexPath.section == 1) {
            cell.imageView?.image = trip.activities[indexPath.row].icon.image()
            cell.textLabel?.text = "\(trip.activities[indexPath.row].name)"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            cell.accessoryType = .none
            
            cell.detailTextLabel?.text = nil
            
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .default
        }
        else if (indexPath.section == 2) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.fetchLimit = 1
            
            let lastImageAsset = PHAsset.fetchAssets(with: .image, options: fetchOptions).firstObject
            
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            
            if (lastImageAsset != nil) {
                manager.requestImage(for: lastImageAsset!,
                                     targetSize: CGSize(width: 40, height: 40),
                                     contentMode: .aspectFit,
                                     options: option,
                                     resultHandler: { (result, info)-> Void in
                    thumbnail = result!
                })
            }
            
            cell.imageView?.image = thumbnail
            cell.textLabel?.text = "\(trip.outfits[indexPath.row].name)"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            cell.accessoryType = .none
            
            cell.detailTextLabel?.text = nil
            
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .default
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if ( indexPath.section == 1 ) {
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) -> Void in
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
                try! realm.write{
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
        
        let OutfitAction = UIAlertAction(title: "Outfit", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let secondViewController = AddOutfitViewController(withExistingTrip: self.trip, withOutfitToEdit: nil, index: -1)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        
        let ActivityAction = UIAlertAction(title: "Activity", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let secondViewController = AddTripActivityViewController(selectedTrip: self.trip)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        
        let ItemAction = UIAlertAction(title: "Item", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let secondViewController = AddItemViewController(withExistingTrip: self.trip, withItemToEdit: nil, index: -1)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionMenu.addAction(ItemAction)
        optionMenu.addAction(ActivityAction)
        optionMenu.addAction(OutfitAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }

    @IBAction func showPackinglist(_ sender: Any) {
        let secondViewController = PackingListViewController(withExistingTrip: self.trip)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}

