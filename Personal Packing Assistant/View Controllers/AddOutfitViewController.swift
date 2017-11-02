//
//  AddOutfitViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/2/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit

class AddOutfitViewController: UIViewController {

    let trip : Trip
    public init(withExistingTrip: Trip ) {
        trip = withExistingTrip
        super.init(nibName: String(describing: AddOutfitViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Outfit"
        
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
        addOutfitToRealm()
        let secondViewController = TripOverviewViewController(withExistingTrip: trip )
        //navigationController?.popViewController(animated: true)
        // Change to navigate to the TripOverviewViewController once it is created
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func addOutfitToRealm() {
        // add activities to Trip
        /*try! realm.write {
         realm.add()
         }*/
    }

}
