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
    let necessities : [String: Any]
    let activity : [String: Any]
    let accomodation : [String: Any]
    let location : [String: Any]
    let weather : [String: Any]
    
    let trip : Trip
    let items : [Item]
    
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
        
        getBasicItems()
        
        getActivityItems()
        
        getWeatherItems()
        
        // Turn the list of items (self.items) into a list of TripItems
        // add code for that
        var packingList : [TripItem] = []
        
        // Change quantities of TripItems for daily things like socks, shirts, etc
        changeItemQuantities()
        
        return packingList
    }
    
    func getBasicItems() {
        // Add basic items that would be used for all trips
        // Example: toothbrush, toothpaste, toilitries, socks, clothes, etc.
        // Add items to the self.items list and make sure there aren't duplicates
    }
    
    func getActivityItems() {
        // Add items based off of the activities they are interested in
        // Add items to the self.items list and make sure there aren't duplicates
    }
    
    func getWeatherItems() {
        // Add items based off of the weather forecast
        // Add items to the self.items list and make sure there aren't duplicates
        // Fetching weather information will be done in WeatherService.swift
    }
    
    func changeItemQuantities() {
        // Change quantity of items based off of the length of the trip
    }
}
