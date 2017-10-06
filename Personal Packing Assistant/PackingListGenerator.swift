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
    var necessities : [String: Any]
    var activity : [String: Any]
    let accomodation : [String: Any]
    let location : [String: Any]
    let weather : [String: Any]
    
    let trip : Trip
    var items : [String]
    
    init(trip : Trip) {
        self.trip = trip
        self.items = []

        // get text from json file
        let url = Bundle.main.url(forResource: "packing_items", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        print(json)

        // parse file contents into dictionaries
        var dictionary = json as! [String: Any]
        self.necessities = dictionary["necessities"] as! [String: Any]
        print("getting necessity items")
        self.activity = dictionary["activity"] as! [String: Any]
        print("getting activity items")
        self.accomodation = dictionary["accomodation"] as! [String: Any]
        print("getting accomodation items")
        self.location = dictionary["location"] as! [String: Any]
        print("getting location items")
        self.weather = dictionary["weather"] as! [String: Any]
        print("getting weather items")
    }
    
    func makeListOfTripItems() -> [TripItem] {
        
        getBasicItems(type: "general")
        
        getActivityItems(type: "fancy")
        
        getWeatherItems(type: "warm")
        
        getLocationItems(type: "domestic")
        
        getAccomodationItems(type: "hostel")
        
        // Turn the list of items (self.items) into a list of TripItems
        // add code for that
        var packingList : [TripItem] = []
        
        // Change quantities of TripItems for daily things like socks, shirts, etc
        changeItemQuantities()
        
        return packingList
    }
    
    func getBasicItems (type: String) {
        // Add basic items that would be used for all trips
        // Example: toothbrush, toothpaste, toilitries, socks, clothes, etc.
        // Add items to the self.items list and make sure there aren't duplicates
        var tempList : [Any]
        tempList = self.necessities.removeValue(forKey: type) as! [Any]
        var i : Int
        i = 1
        var itemsList : [String]
        itemsList = []
        while (i < tempList.count) {
            itemsList.append(tempList.remove(at: i) as! String)
            i = i + 1
        }
        items.append(contentsOf: itemsList)
    }
    
    func getActivityItems(type: String) {
        // Add items based off of the activities they are interested in
        // Add items to the self.items list and make sure there aren't duplicates
        var tempList : [Any]
        tempList = self.activity.removeValue(forKey: type) as! [Any]
        var i : Int
        i = 1
        var itemsList : [String]
        itemsList = []
        while (i < tempList.count) {
            itemsList.append(tempList.remove(at: i) as! String)
            i = i + 1
        }
        items.append(contentsOf: itemsList)
    }
    
    func getWeatherItems(type: String) {
        // Add items based off of the weather forecast
        // Add items to the self.items list and make sure there aren't duplicates
        // Fetching weather information will be done in WeatherService.swift
        var tempList : [Any]
        tempList = self.activity.removeValue(forKey: type) as! [Any]
        var i : Int
        i = 1
        var itemsList : [String]
        itemsList = []
        while (i < tempList.count) {
            itemsList.append(tempList.remove(at: i) as! String)
            i = i + 1
        }
        items.append(contentsOf: itemsList)
    }
    
    func getLocationItems(type: String) {
        // Add items based off of the location
        // Add items to the self.items list and make sure there aren't duplicates
        var tempList : [Any]
        tempList = self.activity.removeValue(forKey: type) as! [Any]
        var i : Int
        i = 1
        var itemsList : [String]
        itemsList = []
        while (i < tempList.count) {
            itemsList.append(tempList.remove(at: i) as! String)
            i = i + 1
        }
        items.append(contentsOf: itemsList)
    }
    
    func getAccomodationItems(type: String) {
        // Add items based off of the accomodation
        // Add items to the self.items list and make sure there aren't duplicates
        var tempList : [Any]
        tempList = self.activity.removeValue(forKey: type) as! [Any]
        var i : Int
        i = 1
        var itemsList : [String]
        itemsList = []
        while (i < tempList.count) {
            itemsList.append(tempList.remove(at: i) as! String)
            i = i + 1
        }
        items.append(contentsOf: itemsList)
    }
    
    func changeItemQuantities() {
        // Change quantity of items based off of the length of the trip
    }
}
