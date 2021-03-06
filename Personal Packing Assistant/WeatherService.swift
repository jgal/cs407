//
//  WeatherService.swift
//  Personal Packing Assistant
//
//  Created by Kristin Beese on 10/5/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import DarkSkyKit

class WeatherService {
    public static let sharedInstance = WeatherService()
    
    // use this class to update Weather models by utilizing the DarkSky API
    let forecastClient = DarkSkyKit(apiToken: "fb81f4a6cb4709d5d4c5364a472333f3")
    
    public func latLong(forTrip: Trip) -> ((Double, Double)) {
        //let location = forTrip.destination
        //return (13.2476889,-57.2342027)
        return (forTrip.coordinates!.latitude, forTrip.coordinates!.longitude)
    }
    
    public func getHistoricalWeather(forDay: Day, inTrip: Trip, complete: @escaping (Error?, Weather?) -> Void) {
        let l = latLong(forTrip: inTrip)
        
        let date = Date(timeIntervalSince1970: Double(UInt64(forDay.date.timeIntervalSince1970)))
        
        forecastClient.timeMachine(latitude: l.0, longitude: l.1, date: date) { (forecast) in
            if let e = forecast.error {
                complete(e, nil)
            }
            
            if let f = forecast.value, let report = f.daily?.first {
                let w = Weather(
                    weatherName: report.summary ?? "n/a",
                    humidity: report.humidity ?? 0.0,
                    precipitation: report.precipProbability ?? 0.0,
                    wind: report.windSpeed ?? 0.0,
                    maxTemp: report.temperatureMax ?? 0.0,
                    minTemp: report.temperatureMin ?? 0.0,
                    location: inTrip.destination,
                    icon: report.icon ?? "n/a"
                )
                
                complete(nil, w)
            }
        }
    }
    
    public func getCurrentWeather(inTrip: Trip, complete: @escaping(Error?, Weather?) -> Void) {
        let l = latLong(forTrip: inTrip)
        
        forecastClient.current(latitude: l.0, longitude: l.1) { (forecast) in
            if let e = forecast.error {
                complete(e, nil)
            }
            
            if let f = forecast.value, let report = f.daily?.first {
                let w = Weather(
                    weatherName: report.summary ?? "n/a",
                    humidity: report.humidity ?? 0.0,
                    precipitation: report.precipProbability ?? 0.0,
                    wind: report.windSpeed ?? 0.0,
                    maxTemp: report.temperatureMax ?? 0.0,
                    minTemp: report.temperatureMin ?? 0.0,
                    location: inTrip.destination,
                    icon: report.icon ?? "n/a"
                )
                
                complete(nil, w)
            }
        }
    }
}
