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
    // MARK: Properties
    @objc dynamic var name: String = ""
    @objc dynamic var destination: String = ""
    @objc dynamic var startDate: NSDate = NSDate()
    @objc dynamic var endDate: NSDate = NSDate()
    
    let days = List<Day>()
    let tripItems = List<TripItem>()
    let activities = List<Activity>()
    let outfits = List<Outfit>()
}

