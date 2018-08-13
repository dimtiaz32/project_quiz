//
//  IntervalQuiz.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 1/14/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import Foundation
import AVFoundation

class IntervalQuiz {
    
    var possibleChoices: Int
    var currentQuestion: IntervalQuestion
    var correctAnswers = 0
    var wrongAnswers = 0
    var isQuestionAnswered = false
    
    let intervalNames = ["P1", "m2", "M2", "m3", "M3", "P4", "Tritone", "P5", "m6", "M6", "m7", "M7", "P8"]

    
    init(possibleAnswers: Int) {
        self.possibleChoices = possibleAnswers // the number of answer buttons in the UI
        self.currentQuestion = IntervalQuestion(maxAnswers: possibleAnswers)
    }
    
    public func nextQuestion() { // makes a new question
        self.isQuestionAnswered = false
        self.currentQuestion = IntervalQuestion(maxAnswers: possibleChoices)
        
//        let saveTool = SaveTool()
//        for interval in intervalNames {
//            print(interval, " Correct: ", saveTool.getCorrectAnswers(forAnswer: interval), " INCORRECT: ", saveTool.getIncorrectAnswers(forAnswer: interval))
//        }
    }
    
    public func answer(answer: String) -> Bool { // function that actually answers the question
        if !self.isQuestionAnswered { // make sure question has not been answered
            let saveTool = SaveTool()
            if answer == currentQuestion.correctAnswer {
                self.correctAnswers += 1
                
                // update the stats that the question was correctly answered
                var correct = saveTool.getCorrectAnswers(forAnswer: currentQuestion.correctAnswer)
                correct += 1
                saveTool.saveCorrectAnswers(number: correct, forAnswer: currentQuestion.correctAnswer)
                
                return true
            } else {
                self.wrongAnswers += 1
                
                // update the stats that the question was incorrectly answered
                var incorrect = saveTool.getIncorrectAnswers(forAnswer: currentQuestion.correctAnswer)
                incorrect += 1
                saveTool.saveIncorrectAnswers(number: incorrect, forAnswer: currentQuestion.correctAnswer)
                
                return false
            }
        }
        
        return false
    }
    
    public func testAnswer(answer: String) -> Bool { // function that returns whether the answer is correct or not
        return answer == currentQuestion.correctAnswer
    }
    
}
