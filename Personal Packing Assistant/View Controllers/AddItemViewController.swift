//
//  AddItemViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import SkyFloatingLabelTextField

class AddItemViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var ItemName: SkyFloatingLabelTextField!
    
    var assignedTrip: Trip
    var currentItem: TripItem?
    var number: Int
    var items: List<TripItem>!
    
    init(withExistingTrip: Trip!, withItemToEdit: TripItem!, index: Int) {
        assignedTrip = withExistingTrip
        self.items = realm.objects(Trip.self).filter("name == %@", assignedTrip.name).first?.tripItems
        self.number = index

        if(self.number != -1) {
            currentItem = self.items[self.number]
        } else {
            currentItem = TripItem()
        }
        
        
        super.init(nibName: String(describing: AddItemViewController.self), bundle: Bundle.main)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Item"
        
        let buttonTitle = "Done"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(doneButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = true

        if (self.number != -1) {
            ItemName.text = currentItem?.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Button Done
    @objc func doneButtonTapped(_ sender: UIButton) {
        addItemToRealm()
        let alltripsVC = AllTripsTableViewController()
        let tripoverview = TripOverviewViewController(withExistingTrip: assignedTrip )
         let secondViewController = PackingListViewController(withExistingTrip: self.assignedTrip)
        
        var vcs = [
            navigationController?.viewControllers[0],
            alltripsVC,
            tripoverview,
            secondViewController
        ]
        
        navigationController?.setViewControllers(vcs as! [UIViewController], animated: true)
       
        //navigationController?.pushViewController(secondViewController, animated: true)
    }
    func addItemToRealm() {
        try! realm.write {
            let i = TripItem()
            print(ItemName.text!)
            i.name = ItemName.text!
            
            if (number != -1) {
                self.assignedTrip.tripItems[number] = i
            } else {
                self.assignedTrip.tripItems.append(i)
                currentItem = i
            }
        }
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
