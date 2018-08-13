//
//  IntervalQuestion.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 1/14/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import Foundation

class IntervalQuestion {
    
    //some constants
    let intervalNames = ["P1", "m2", "M2", "m3", "M3", "P4", "Tritone", "P5", "m6", "M6", "m7", "M7", "P8"]
    let noteNames = ["C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Gb", "A", "A#/Bb", "B"]
    var stepsForInterval = [String:Int]()
    var selectedIntervals : [String]  // the intervals the user wants to be quizzed on
    
    var numberOfAnswers: Int
    var possibleAnswers: [String] // one correct answer and the rest are incorrect
    var correctAnswer: String
    var startNote = ""
    var endNote = ""
    var startNoteFile = ""
    var endNoteFile = ""
    
    init(maxAnswers: Int) { // basically make a question
        for (index, interval) in intervalNames.enumerated() { // set up a dictionary to match an interval to the half steps
            stepsForInterval[interval] = index
        }
        
        let tools = SettingsTool()
        self.selectedIntervals = tools.getIntervals()
        self.numberOfAnswers = maxAnswers 
        self.possibleAnswers = []
        self.correctAnswer = ""
        
        self.createQuestion()
    }
    
    private func createQuestion() {
        // pick a random interval - start with a random starting note
        let startNote = Int(arc4random_uniform((UInt32(Constants.range)))) + 24 //Not 88 in case it goes over? (88 - 12 - 24)
        let interval = selectedIntervals[Int(arc4random_uniform(UInt32(selectedIntervals.count)))] // the random interval
        let intervalSize = stepsForInterval[interval] // the number of half steps
        let endNote = startNote + intervalSize!      // the last note
        
        self.startNoteFile = String(startNote)
        self.endNoteFile = String(endNote)
        self.startNote = noteNames[startNote % 12]
        self.endNote = noteNames[endNote % 12]
        
        // now make the array of answer choices
        var added = false // keep track if the correct answer is added to the array of answers
        var intervals = [String]()
        var wrongIntervals = self.selectedIntervals.filter({$0 != interval})
        
        for _ in 0..<self.numberOfAnswers - 1 { // now add wrong intervals
            
            // in case there are less selected intervals than there are answers to return
            // the size of the selectedIntervals array may be smaller than the numberOfAnswers to return
            if wrongIntervals.count > 0 {
                // select a wrong interval and then remove it from the array
                let wrongInterval = wrongIntervals[Int(arc4random_uniform(UInt32(wrongIntervals.count)))]
                if let index = wrongIntervals.index(of: wrongInterval) {
                    intervals.append(wrongInterval)
                    wrongIntervals.remove(at: index)
                }
            } else {
                intervals.append("-")
            }
            
            //randomizes the correct answer placement a bit
            if drand48() > 0.5 && !added {
                intervals.append(interval)
                added = true
            }
        }
        
        if !added { intervals.append(interval) } // add correct answer if not added
        
        self.correctAnswer = interval
        self.possibleAnswers = intervals
    }
    
    private func isInArray(string: String, array: [String]) -> Bool {
        for i in array {
            if i == string { return true }
        }
        return false
    }
    
    enum Constants {
        static let numNotes = 12
        static let range = 48
    }
}
