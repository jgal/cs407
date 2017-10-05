//
//  PackingListGenerator.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 9/29/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation

class PackingListGenerator {
    
    let trip : Trip
    let items : [Item]
    
    init(trip : Trip) {
        self.trip = trip
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
