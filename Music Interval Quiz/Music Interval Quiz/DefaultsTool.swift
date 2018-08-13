//
//  DefaultsTool.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 7/31/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import Foundation

class DefaultsTool {
    let defaults = UserDefaults.standard
    
    public func saveIntervals(intervals: [String]) {
        defaults.set(intervals, forKey: Keys.TESTED_INTERVALS_KEY)
        print("saved the new intervals")
    }
    
    public func getIntervals() -> [String] {
        if let value = defaults.stringArray(forKey: Keys.TESTED_INTERVALS_KEY) {
            return value
        } else {
            return ["P1", "m2", "M2", "m3", "M3", "P4", "Tritone", "P5", "m6", "M6", "m7", "M7", "P8"]
        }
    }
    
    enum Keys {
        static let TESTED_INTERVALS_KEY = "tested_intervals"
        static let HIGH_SCORE_KEY = "high_score"
    }
}
