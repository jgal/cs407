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
    @IBOutlet weak var add: UIBarButtonItem!
    
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
        
        title = "\(trip.name) Overview"
        
        // let buttonTitle = "🗒"
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        //navigationItem.leftBarButtonItem?.isEnabled = false
        
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
