//
//  Item.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    // MARK: Properties
    @objc dynamic var name: String = ""
    //@objc dynamic var photos : String = ""     //URL implementation?
    //@objc dynamic var photo: UIImage = UIImage() // Might be better to use a UIImage instead
    @objc dynamic var worn: Bool = false
    let categories = List<Category>()
}
