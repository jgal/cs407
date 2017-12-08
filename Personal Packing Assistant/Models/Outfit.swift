//
//  Outfit.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import RealmSwift

class Outfit : Object {
    // MARK: Properties
    @objc dynamic var name: String = ""
    @objc dynamic var image: Data?
    
    let items = List<Item>()
    let categories = List<Category>()
    
}
