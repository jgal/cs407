//
//  AddOutfitViewController.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/2/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import SkyFloatingLabelTextField

class AddOutfitViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var OutfitImageView: UIImageView!
    @IBOutlet weak var TakePhotoButton: UIButton!
    @IBOutlet weak var OutfitNameTextField: SkyFloatingLabelTextField!
    var imagePicker = UIImagePickerController()
    let assignedTrip : Trip
    var currentOutfit: Outfit?
    var number: Int
    var dayIndex: Int
    var day: Day
    var outfits: List<Outfit>!
    var image : UIImage?
    
    public init(withExistingTrip: Trip, dayIndex: Int, withOutfitToEdit: Outfit!, outfitIndex: Int) {
        assignedTrip = withExistingTrip
        self.number = outfitIndex
        self.dayIndex = dayIndex
        day = self.assignedTrip.days[self.dayIndex]
        self.outfits = self.day.outfits
        if(self.number != -1) {
            print("in if statement")
            currentOutfit = self.outfits[self.number]
        } else {
            currentOutfit = Outfit()
        }
        
        super.init(nibName: String(describing: AddOutfitViewController.self), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("add outfit did load")
        super.viewDidLoad()
        
        title = "Add Outfit"
        
        
        let buttonTitle = "Done"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(doneButtonTapped(_:)))
        //navigationItem.rightBarButtonItem?.isEnabled = false
        
        if (self.number != -1) {
            OutfitNameTextField.text = currentOutfit?.name
            OutfitImageView.contentMode = .scaleToFill
            image = UIImage(data: (currentOutfit?.image)!)
            OutfitImageView.image = UIImage(data: (currentOutfit?.image)!)
        }
            OutfitImageView.contentMode = .scaleToFill
            //OutfitImageView.image = UIImage(named: "no_image")
       
    
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
         addOutfitToRealm()
        // addOutfitToRealm()
        
        print("trip name: \(assignedTrip.name) dayIndex: \(dayIndex)")
        
        let alltripsVC = TripOverviewViewController(withExistingTrip: self.assignedTrip)
        
        
         let secondViewController = DayOverviewViewController(withExistingTrip: assignedTrip, indexPathRow: dayIndex )
        let vcs = [
            navigationController?.viewControllers[0],
            alltripsVC,
            secondViewController
        ]
        print("just before DayOverview")
        navigationController?.setViewControllers(vcs as! [UIViewController], animated: true)
        
    }
    
    @IBAction func takePhotoTapped(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            print("Open Camera")
    
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = false
        
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        let libraryAction = UIAlertAction(title: "Open Library", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            print("Open Photo Library")
            
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .savedPhotosAlbum;
                self.imagePicker.allowsEditing = false
                
                self.present(self.imagePicker, animated: true, completion: nil)
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
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.OutfitImageView.contentMode = .scaleToFill
                self.OutfitImageView.image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
    }
    
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func addOutfitToRealm() {
        let o = Outfit()
        
        print(OutfitNameTextField.text!)
        o.name = OutfitNameTextField.text!
        let imageData = UIImagePNGRepresentation(OutfitImageView.image!)
        o.image = imageData
        
        // TODO add to data structure
        print("row number is \(self.number)")
        try! realm.write {
            if (number != -1) {
                self.day.outfits[number] = o
            } else {
                print("in else")
                self.day.outfits.append(o)
                currentOutfit = o
                print("added to outfit list")
            }
        }
    }
}
