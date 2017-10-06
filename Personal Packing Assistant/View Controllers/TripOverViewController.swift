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
    

    

}
