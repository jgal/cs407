//
//  AddTripActivityViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/1/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class AddTripActivityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let currentTrip: Trip
    var activities : Results<Activity>!
    @IBOutlet weak var activityCollection: UICollectionView!
    
    public init(selectedTrip: Trip) {
        currentTrip = selectedTrip
        super.init(nibName: String(describing: AddTripActivityViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Activity"
        
        let buttonTitle = "Next"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        //navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.activityCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        activityCollection.delegate = self
        activityCollection.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readTasksAndUpdateUI()
        print("viewWillAppear")
    }
    
    func readTasksAndUpdateUI() {
        self.activities = realm.objects(Activity.self)

        self.activityCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("num activities: \(activities.count) " )
       return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UICollectionViewCell = self.activityCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        /*let titleLabel = UILabel()
        titleLabel.text = self.activities[indexPath.row].icon
        titleLabel.textColor = UIColor.black
        cell.addSubview(titleLabel)*/
        cell.backgroundColor = UIColor.blue
    
        return cell
        //cell.backgroundColor = UIColor.black
        //cell.text = self.activities[indexPath.row].name
        //cell.textLabel?.text = self.activities[indexPath.row].name
        //cell.backgroundView.
        
        //return cell
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        addActivityToRealm()
        let secondViewController = TripOverviewViewController(withExistingTrip: currentTrip )
        //navigationController?.popViewController(animated: true)
        // Change to navigate to the TripOverviewViewController once it is created
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func addActivityToRealm() {
        // add activities to Trip
        /*try! realm.write {
                realm.add()
        }*/
    }
    

   

}
