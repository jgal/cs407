//
//  AddTripActivitiesViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class AddTripActivitiesViewController: UIViewController {

    
    public init() {
        super.init(nibName: String(describing: AddTripActivitiesViewController.self), bundle: Bundle.main)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.activitiesCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
       // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddActivityButtonTapped(_:)))
        
        let buttonTitle = "Next"
        title = "Add Activity"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(AddActivityButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        readTasksAndUpdateUI()
        print("viewWillAppear")
    }
    
    func readTasksAndUpdateUI() {
        //self.activitiesCollection.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    @objc func AddActivityButtonTapped(_ sender: UIBarButtonItem) {
        print("Add New Activity")
        //let secondViewController = AddTripViewController()
        //navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
}
