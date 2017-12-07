//
//  Trip.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class Location: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    
    /// Computed properties are ignored in Realm
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}

class Trip : Object {
    // MARK: Properties
    @objc dynamic var id = UUID().uuidString
    
    @objc dynamic var name: String = ""
    @objc dynamic var destination: String = ""
    @objc dynamic var traveler: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var startDate: Date? = nil
    @objc dynamic var endDate: Date? = nil
    
    @objc dynamic var coordinates: Location? = nil
    
    let days = List<Day>()
    let tripItems = List<TripItem>()
    let items = List<Item>()
    let activities = List<Activity>()
    let outfits = List<Outfit>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

