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

class DayOverviewViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    let tripName: String
    var day: Day!
    var trip : Trip!
    
    var outfits: List<Outfit>!
    var activities: List<Activity>!
    
    public init(withExistingTrip: Trip, selectedDay: Day) {
        tripName = withExistingTrip.name
        day = selectedDay
        super.init(nibName: String(describing: TripOverviewViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
