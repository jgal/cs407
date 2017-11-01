//
//  PackingListViewController.swift
//  Personal Packing Assistant
//
//  Created by Janka on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import RealmSwift
import Foundation
import UIKit

class PackingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var packingListTable: UITableView!
    
    init() {
        
        super.init(nibName: String(describing: PackingListViewController.self), bundle: Bundle.main)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Packing List"
        // Do any additional setup after loading the view.
        
        self.packingListTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        title = "Packing List"
        packingListTable.delegate = self
        packingListTable.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
