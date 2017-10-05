//
//  Trip.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import RealmSwift

class Trip : Object {
    @objc dynamic var name: String = ""
    
    let days = List<Day>()
}

