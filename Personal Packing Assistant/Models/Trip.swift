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
    @objc dynamic var traveler: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var startDate: Date? = nil
    @objc dynamic var endDate: Date? = nil
    
    let days = List<Day>()
    let tripItems = List<TripItem>()
    let items = List<Item>()
    let activities = List<Activity>()
    let outfits = List<Outfit>()
}

