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
    
    
    var assignedTrip: Trip
    var currentItem: TripItem?
    var number: Int
    var items: List<TripItem>!
    var quant: Int
    
    let blueColor = UIColor(red: 60/255, green: 155/255, blue: 175/255, alpha: 1.0)
    let greyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    
    @IBOutlet weak var ItemName: SkyFloatingLabelTextField!
    @IBOutlet weak var Quantity: SkyFloatingLabelTextField!
    @IBOutlet weak var DecQ: UIButton!
    @IBOutlet weak var IncQ: UIButton!
    
    
    public init(withExistingTrip: Trip!, withItemToEdit: TripItem!, index: Int) {
        assignedTrip = withExistingTrip
        self.items = realm.objects(Trip.self).filter("name == %@", assignedTrip.name).first?.tripItems
        self.quant = 0
        self.number = -1
        currentItem = withItemToEdit
        var count = 0;
        for item in assignedTrip.tripItems {
            if (item.name ==  currentItem?.name) {
                self.number = count
                self.quant = (currentItem?.quantity)!
                print("exists")
                break
            }
            count += 1;
        }
        print("\(self.number)  exists")
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
            print("please be here  1")
            ItemName.text = currentItem?.name
            var k :String
            k = String((currentItem?.quantity)!)
            self.quant = (currentItem?.quantity)!
            Quantity.text = k
        } else {
            quant = 0
            Quantity.text = "0"
        }
        ItemName.tintColor = blueColor
        ItemName.lineColor = blueColor
        ItemName.selectedTitleColor = blueColor
        ItemName.selectedLineColor = blueColor
        Quantity.tintColor = blueColor
        Quantity.lineColor = blueColor
        Quantity.selectedTitleColor = blueColor
        Quantity.selectedLineColor = blueColor
        //DecQ.tintColor = blueColor
       // IncQ.tintColor = blueColor
        //DecQ.backgroundColor = blueColor
       // IncQ.backgroundColor = blueColor
        DecQ.backgroundColor = .clear
        DecQ.layer.cornerRadius = 4
        DecQ.layer.borderWidth = 2
        DecQ.layer.borderColor = blueColor.cgColor
        IncQ.backgroundColor = .clear
        IncQ.layer.cornerRadius = 4
        IncQ.layer.borderWidth = 2
        IncQ.layer.borderColor = blueColor.cgColor
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
            i.quantity = self.quant
            
            if (number != -1) {
                print("please be here 2")
                self.assignedTrip.tripItems[number] = i
            } else {
                self.assignedTrip.tripItems.append(i)
                currentItem = i
            }
        }
    }

    @IBAction func DecQuantity(_ sender: Any) {
        
        if ( self.quant > 1) {
            var k :String
            self.quant -= 1
            k = String(self.quant)
            Quantity.text = k
        }
    }
    
    @IBAction func IncQuantity(_ sender: Any) {
        if ( self.quant < 99) {
            var k :String
            self.quant += 1
            k = String(self.quant)
            Quantity.text = k
        }
    }
    
    
}
