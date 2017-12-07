//
//  PackingListGenerator.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import RealmSwift

class PackingListGenerator {
    // item dictionaries initialized here
    var necessities : [String: [String]]
    var activity : [String: [String: [String]]]
    let weather : [String: [String: [String]]]
    
    let trip : Trip
    var items : [String]
    
    public static func getActivities() -> [Activity] {
        let url = Bundle.main.url(forResource: "packing_items", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        var dictionary = json as! [String: Any]

        let activities = dictionary["activities"] as! [[String: String]]
        
        return activities.map({ (dict) in
            let a = Activity()
            a.icon = dict["emoji"]!
            a.name = dict["name"]!
            return a
        })
    }
    
    init(trip : Trip) {
        self.trip = trip
        self.items = []

        // get text from json file
        let url = Bundle.main.url(forResource: "packing_items", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])

        // parse file contents into dictionaries
        var dictionary = json as! [String: Any]
        self.necessities = dictionary["necessities"] as! [String: [String]]
        self.activity = dictionary["activity"] as! [String: [String: [String]]]
        self.weather = dictionary["weather"] as! [String: [String: [String]]]
    }
    
    func makeListOfTripItems() -> [TripItem] {
        
        let gender = self.trip.gender.lowercased()
        
        getBasicItems(gender: gender)
        
        for activity in self.trip.activities {
            getActivityItems(gender: gender, activity: activity)
        }
        
        // get weather data
        // getWeatherItems(weather: weather, gender: gender)
        
        var packingList : [TripItem] = self.items.map { (name) -> TripItem in
            let i = TripItem()
            i.name = name
            i.packed = false
            i.quantity = 1
            
            return i
        }
        
        // Change quantities of TripItems for daily things like socks, shirts, etc
        packingList = changeItemQuantities(tripItems: packingList)
        
        return packingList
    }
    
    func getBasicItems (gender: String) {
        items.append(contentsOf: self.necessities[gender]!.map({ $0 }))
        items.append(contentsOf: self.necessities["general"]!.map({ $0 }))
    }
    
    func getActivityItems(gender: String, activity: Activity) {
        if activity.name == "fancy" {
            items.append(contentsOf: self.activity[activity.name]![gender]!.map({ $0 }))
        } else {
            items.append(contentsOf: self.activity[activity.name]!["general"]!.map({ $0 }))
        }
    }
    
    func getWeatherItems(weather: String, gender: String) {
        items.append(contentsOf: self.activity[weather]![gender]!.map({ $0 }))
        items.append(contentsOf: self.activity[weather]!["general"]!.map({ $0 }))
    }
    
    func changeItemQuantities(tripItems: [TripItem]) -> [TripItem] {
        // Change quantity of items based off of the length of the trip
        let day_count = trip.days.count
        let everyDayItems = ["undergarments", "t-shirt", "socks"]
        let someDayItems = ["jeans/pants", "shorts"]
        let fewDayItems = ["comfortable walking shoes"]
        for item in tripItems {
            if everyDayItems.contains(item.name) {
                item.quantity = day_count
            } else if someDayItems.contains(item.name) {
                if day_count < 3 {
                    item.quantity = day_count
                } else {
                    item.quantity = day_count / 2
                }
            } else if fewDayItems.contains(item.name) {
                if day_count < 5 {
                    item.quantity = 1
                } else if day_count < 10 {
                    item.quantity = 2
                } else {
                    item.quantity = 3
                }
            }
        }
        return tripItems
    }
}
