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
    // MARK: Properties
    // The "dynamic var" type fields are saved in Realm
    @objc dynamic var weatherName: String = ""
    @objc dynamic var humidity: Double = 0
    @objc dynamic var precipitation: Double = 0
    @objc dynamic var wind: Double = 0
    @objc dynamic var maxTemp: Double = 0
    @objc dynamic var minTemp: Double = 0
    @objc dynamic var location: String = ""
    @objc dynamic var icon: String = ""
    
    public convenience init(
        weatherName: String,
        humidity: Double,
        precipitation: Double,
        wind: Double,
        maxTemp: Double,
        minTemp: Double,
        location: String,
        icon: String
    ) {
        self.init()
        
        self.weatherName = weatherName
        self.humidity = humidity
        self.precipitation = precipitation
        self.wind = wind
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.location = location
        self.icon = icon
    }

}
