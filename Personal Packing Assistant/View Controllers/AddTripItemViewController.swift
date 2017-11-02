//
//  AddTripItemViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/2/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit

class AddTripItemViewController: UIViewController {

    let trip : Trip
    public init(withExistingTrip: Trip ) {
        trip = withExistingTrip
        super.init(nibName: String(describing: AddTripItemViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Trip Item"
        
        let buttonTitle = "Next"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(nextButtonTapped(_:)))
        //navigationItem.rightBarButtonItem?.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        addTripItemToRealm()
        let secondViewController = TripOverviewViewController(withExistingTrip: trip )
        //navigationController?.popViewController(animated: true)
        // Change to navigate to the TripOverviewViewController once it is created
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func addTripItemToRealm() {
        // add activities to Trip
        /*try! realm.write {
         realm.add()
         }*/
    }

}
