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

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var activityTable: UITableView!
    
    init() {
        
        super.init(nibName: String(describing: AddTripActivitiesViewController.self), bundle: Bundle.main)
        @IBOutlet weak var ActivityTable: UITableView!
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
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
    
    @IBAction func backButtonTapped(sender: UIButton) {
        print("backButtonTapped: before push")
        let backViewController = AddTripViewController()
        self.present(secondViewController, animated: true, completion: nil)
        print("backButtonTapped: after push")
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        print("nextButtonTapped: before push")
        let nextViewController = PackingListViewController()
        self.present(secondViewController, animated: true, completion: nil)
        print("nextButtonTapped: after push")
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
