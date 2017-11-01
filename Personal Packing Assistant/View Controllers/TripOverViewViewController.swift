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

class TripOverviewViewController: UIViewController {

    let trip : Trip
    public init(withExistingTrip: Trip ) {
        trip = withExistingTrip
        super.init(nibName: String(describing: TripOverviewViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "\(trip.name) +  Trip Overview"
        
        let buttonTitle = "🏠"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        //navigationItem.rightBarButtonItem?.isEnabled = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readTripsAndUpdateUI()
    }

    func readTripsAndUpdateUI(){
        
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
         let secondViewController = AllTripsTableViewController()
        // navigationController?.popViewController(animated: true)
        // Change to navigate to the TripOverviewViewController once it is created
         navigationController?.pushViewController(secondViewController, animated: true)
    }
    

}
