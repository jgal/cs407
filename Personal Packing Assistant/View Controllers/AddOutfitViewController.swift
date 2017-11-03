//
//  AddOutfitViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/2/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddOutfitViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var OutfitImageView: UIImageView!
    @IBOutlet weak var TakePhotoButton: UIButton!
    @IBOutlet weak var OutfitNameTextField: SkyFloatingLabelTextField!
    
    let assignedTrip : Trip
    
    public init(withExistingTrip: Trip ) {
        assignedTrip = withExistingTrip
        
        super.init(nibName: String(describing: AddOutfitViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Outfit"
        
        let buttonTitle = "Done"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(doneButtonTapped(_:)))
        //navigationItem.rightBarButtonItem?.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func doneButtonTapped(_ sender: UIButton) {
        // save photo to library (if taken on camera) and store file path
        //var imageData = UIImageJPEGRepresentation(OutfitImageView.image!, 1)
        //var compressedJPEGImage = UIImage(data: imageData!)
        //UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        
        // TODO
        // addOutfitToRealm()
         let secondViewController = TripOverviewViewController(withExistingTrip: assignedTrip )
        let alltripsVC = AllTripsTableViewController()
        var vcs = [
            navigationController?.viewControllers[0],
            alltripsVC,
            secondViewController
        ]
        
        navigationController?.setViewControllers(vcs as! [UIViewController], animated: true)
       
        //avigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func takePhotoTapped(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            print("Open Camera")
    
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                var imagePicker = UIImagePickerController()
                imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
        
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        let libraryAction = UIAlertAction(title: "Open Library", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            print("Open Photo Library")
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                var imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(libraryAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        OutfitImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func addOutfitToRealm() {
        let o = Outfit()
        
        print(OutfitNameTextField.text!)
        o.name = OutfitNameTextField.text!
        
        // TODO add to data structure
        
        try! realm.write {
            realm.add(o)
        }
    }

}