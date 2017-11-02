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
    let newItem: Item?
    
    init(withExistingTrip: Trip!, withItemToEdit: Item!) {
        assignedTrip = withExistingTrip
        if (withItemToEdit != nil) {
            newItem = withItemToEdit!
        } else{
            newItem = Item()
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
        
        if let t = newItem {
            ItemName.text = t.name;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Button Done
    @objc func doneButtonTapped(_ sender: UIButton) {
        // TODO add item to data structure
        addItemToRealm()
        
        let secondViewController = PackingListViewController(withExistingTrip: self.assignedTrip)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    func addItemToRealm() {
        // TODO
        try! realm.write {
            let i = Item()
            
            print(ItemName.text!)
            i.name = ItemName.text!
            // i.categories = ItemName.text
            
            // TODO add to data structure?
            realm.add(i)
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
