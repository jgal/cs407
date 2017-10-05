//
//  Weather.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import RealmSwift

class Weather : Object {
    // The "dynamic var" type fields are saved in Realm
    @objc dynamic var weatherName: String = ""
    @objc dynamic var humidity: Int = 0
    @objc dynamic var precipitation: Int = 0
    @objc dynamic var wind: Int = 0
    @objc dynamic var maxTemp: Int = 0
    @objc dynamic var minTemp: Int = 0
    @objc dynamic var location: String = ""    
}
