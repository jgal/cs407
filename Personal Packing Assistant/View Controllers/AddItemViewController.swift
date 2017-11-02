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

class AddItemViewController: UIViewController, UITextFieldDelegate {

    init() {
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Button Done
    @objc func doneButtonTapped(_ sender: UIButton) {
        addItemToRealm()
        
        let secondViewController = PackingListViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    func addItemToRealm() {
        // TODO
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
