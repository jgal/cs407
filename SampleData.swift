//
//  SampleData.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/1/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation

public class SampleData {
    
    public static func generateAndSaveData() {
        let a1 = Activity()
        a1.name = "🏊"
        let a2 = Activity()
        a2.name = "⛺"
        let a3 = Activity()
        a3.name = "🎣"
        realm.add(a1)
        realm.add(a2)
        realm.add(a3)
        
    }
}
