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

class DayOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    @IBOutlet weak var table: UITableView!
    let tripName: String
    var day: Day!
    var trip : Trip!
    var row: Int
    
    var outfits: List<Outfit>!
    var activities: List<Activity>!
    
    public init(withExistingTrip: Trip, selectedDay: Day, indexPathRow: Int) {

        tripName = withExistingTrip.name
        day = selectedDay
        row = indexPathRow
          //          cell.textLabel?.text =
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = self.table.dequeueReusableCell(withIdentifier: "subtitle")
        
        
        let day = trip.days[indexPath.row]
        let weather = day.weather!
        
        if c == nil {
            c = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
        }
        
        let cell = c!
        
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
