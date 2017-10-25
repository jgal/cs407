//
//  Day.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import RealmSwift

class Day : Object {
    // MARK: Properties
    @objc dynamic var date: Date = Date()
    
    public convenience init(_ date: Date) {
        self.init()
        
        self.date = date
    }
    
    var weather: Weather = Weather()
    let items = List<Item>()
    let activities = List<Activity>()
    let outfits = List<Outfit>()
}

