//
//  SaveTool.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 7/31/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import Foundation


class SaveTool {
    
    let defaults = UserDefaults.standard
    
    public func saveIntervals(intervals: [String]) {
        defaults.set(intervals, forKey: Keys.TESTED_INTERVALS_KEY)
    }
    
    public func getIntervals() -> [String] {
        if let value = defaults.stringArray(forKey: Keys.TESTED_INTERVALS_KEY) {
            return value
        } else {
            return ["P1", "m2", "M2", "m3", "M3", "P4", "Tritone", "P5", "m6", "M6", "m7", "M7", "P8"]
        }
    }
    
    public func saveHighScore(score: Int) {
        defaults.set(score, forKey: Keys.HIGH_SCORE_KEY)
    }
    
    public func getHighScore() -> Int {
        return defaults.integer(forKey: Keys.HIGH_SCORE_KEY)
    }
    
    public func saveIncorrectAnswers(number: Int, forAnswer answer: String) {
        if let key = Keys.INCORRECT_INTERVAL_KEYS[answer] {
            defaults.set(number, forKey: key)
        }
    }
    
    public func saveCorrectAnswers(number: Int, forAnswer answer: String) {
        if let key = Keys.CORRECT_INTERVAL_KEYS[answer] {
            defaults.set(number, forKey: key)
        }
    }
    
    public func getIncorrectAnswers(forAnswer answer: String) -> Int {
        if let key = Keys.INCORRECT_INTERVAL_KEYS[answer] {
            return defaults.integer(forKey: key)
        } else {
            return 0
        }
    }
    
    public func getCorrectAnswers(forAnswer answer: String) -> Int {
        if let key = Keys.CORRECT_INTERVAL_KEYS[answer] {
            return defaults.integer(forKey: key)
        } else {
            return 0
        }
    }
    
    enum Keys {
        static let TESTED_INTERVALS_KEY = "tested_intervals"
        static let HIGH_SCORE_KEY = "high_score"
        
        static let INCORRECT_INTERVAL_KEYS = ["P1":"perfect_unision_incorrect",
                                    "m2":"minor_second_incorrect",
                                    "M2":"major_second_incorrect",
                                    "m3":"minor_third_incorrect",
                                    "M3":"major_third_incorrect",
                                    "P4":"perfect_fourth_incorrect",
                                    "Tritone":"tritone_incorrect",
                                    "P5":"perfect_fifth_incorrect",
                                    "m6":"minor_sixth_incorrect",
                                    "M6":"major_sixth_incorrect",
                                    "m7":"minor_seventh_incorrect",
                                    "M7":"major_seventh_incorrect",
                                    "P8":"perfect_eighth_incorrect"]
        
        static let CORRECT_INTERVAL_KEYS = ["P1":"perfect_unision_correct",
                                              "m2":"minor_second_correct",
                                              "M2":"major_second_correct",
                                              "m3":"minor_third_correct",
                                              "M3":"major_third_correct",
                                              "P4":"perfect_fourth_correct",
                                              "Tritone":"tritone_correct",
                                              "P5":"perfect_fifth_correct",
                                              "m6":"minor_sixth_correct",
                                              "M6":"major_sixth_correct",
                                              "m7":"minor_seventh_correct",
                                              "M7":"major_seventh_correct",
                                              "P8":"perfect_eighth_correct"]
    }
    
}
