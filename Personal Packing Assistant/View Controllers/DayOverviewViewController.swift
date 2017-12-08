//
//  DayOverviewViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 12/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import Photos

class DayOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    @IBOutlet weak var table: UITableView!
    let tripName: String
    var day: Day!
    var trip : Trip!
    var row: Int
    
    var outfits: List<Outfit>!
    var activities: List<Activity>!
    
    public init(withExistingTrip: Trip, indexPathRow: Int) {
        trip = withExistingTrip
        tripName = withExistingTrip.name
        row = indexPathRow
        day = trip.days[row]
       
        super.init(nibName: String(describing: DayOverviewViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readTasksAndUpdateUI()
              
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMMM d, yyy"
        title = "Day \(row+1): \(formatter.string(from: day.date))"

        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 44
        table.delegate = self
        table.dataSource = self
        
        // Do any additional setup after loading the view.
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ( section  ) {
        case 0:
            return 1 //weather
        case 1:
            return self.day.activities.count 
        case 2:
            return self.day.outfits.count
        default:
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if ( section == 0) {
            return "Weather"
        } else if ( section == 1) {
            return "List of Activities"
        }
        else if (section == 2) {
            return "List of Outfits"
        }
        else {
            return "Default"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = self.table.dequeueReusableCell(withIdentifier: "subtitle")
        
        
        let day = trip.days[indexPath.row]
        let weather = day.weather!
        
        if c == nil {
            c = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
        }
        
        let cell = c!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMMM d, yyy"
        if (indexPath.section == 0) {
            cell.textLabel?.text = "\(weather.emoji)"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
            
            cell.detailTextLabel?.text = "Low: \(String(format: "%.0f", weather.minTemp))℉  Hi: \(String(format: "%.0f", weather.maxTemp))℉.\n\(weather.weatherName)"
            cell.detailTextLabel?.numberOfLines = 0
            
            cell.accessoryType = .none
            cell.selectionStyle = .none
        } else if (indexPath.section == 1) {
            cell.imageView?.image = day.activities[indexPath.row].icon.image()
            cell.textLabel?.text = "\(day.activities[indexPath.row].name)"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            cell.accessoryType = .none
            
            cell.detailTextLabel?.text = nil
            
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .default
            
        } else if (indexPath.section == 2) {
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
            cell.textLabel?.text = "\(day.outfits[indexPath.row].name)"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            cell.accessoryType = .none
            
            cell.detailTextLabel?.text = nil
            
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .default
        }

        
        
        
        return cell
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
