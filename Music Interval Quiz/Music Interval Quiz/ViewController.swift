//
//  ViewController.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 1/14/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable
class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var incorrectScoreLbl: UILabel!
    @IBOutlet weak var intervalLbl: UILabel!
    @IBOutlet weak var correctScoreLbl: UILabel!
    
    @IBOutlet weak var answerOneBtn: UIButton!
    @IBOutlet weak var answerTwoBtn: UIButton!
    @IBOutlet weak var answerThreeBtn: UIButton!
    @IBOutlet weak var answerFourBtn: UIButton!
    @IBOutlet weak var nextQuestionBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var quitBtn: UIButton!
    
    var player: AVAudioPlayer?
    var player2: AVAudioPlayer?
    var answered = false // keeps track if the question is answered or not if the user leaves the app and comes back to it
    var answerButtons: [UIButton]!
    lazy var quiz = IntervalQuiz(possibleAnswers: self.answerButtons.count)
    
    var playBtnShadow : UIView?
    var isPlayerSetUp = false
    
    // View Controller Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerButtons = [self.answerOneBtn, self.answerTwoBtn, self.answerThreeBtn, self.answerFourBtn]
        self.setupUI()
        self.setUpPlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if playBtnShadow == nil {
            addShadowForButton(view: self.view, button: playBtn, opacity: 0.5)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // if the view will disappear and the player is playing, stop playing
        if let p = player {
            if p.isPlaying {
                p.stop()
            }
        }
        if let p2 = player2 {
            if p2.isPlaying {
                p2.stop()
            }
        }
    }
    
    
    // Segue functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let identifier = segue.identifier {
            switch identifier {
            case "back_to_menu":
                // save the high score
                if let currentScore = Int(correctScoreLbl.text!) {
                    let saveTool = SaveTool()
                    let highScore = saveTool.getHighScore()
                    if currentScore > highScore {
                        saveTool.saveHighScore(score: currentScore)
                    }
                }
                
            default:
                print("strange case!")
            }
        }
    }

    
    // UIButton events
    @IBAction func quitBtnTpd(_ sender: UIButton) {
        // Create alert to user to confirm that the session will be ended and high score will be saved
        let alert = UIAlertController(title: "Are you sure you want to quit?", message: "You will lose your progress. (High score will be saved)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.performSegue(withIdentifier: "back_to_menu", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func answerBtnTpd(_ sender: UIButton) {
        nextQuestionBtn.isHidden = false
        self.answered = true
        if quiz.answer(answer: (sender.titleLabel?.text)!) {
            // update ui for correct answer
            intervalLbl.text = "Correct! " + quiz.currentQuestion.startNote + " - " + quiz.currentQuestion.endNote
            correctScoreLbl.text = String(quiz.correctAnswers)
            sender.backgroundColor = UIColor.green
            for button in answerButtons {
                button.isEnabled = false
            }
        } else {
            // update ui for wrong answer
            intervalLbl.text = "Incorrect! " + quiz.currentQuestion.startNote + " - " + quiz.currentQuestion.endNote
            incorrectScoreLbl.text = String(quiz.wrongAnswers)
            sender.backgroundColor = UIColor.red
            for button in answerButtons {
                button.isEnabled = false
                if quiz.testAnswer(answer: (button.titleLabel?.text)!) {
                    // correct answer
                    button.backgroundColor = UIColor.green
                }
            }
        }
        self.quiz.nextQuestion() // get the next question ready
    }
    
    @IBAction func playBtnTpd(_ sender: UIButton) {
        if isPlayerSetUp {
            if let p = player {
                if !p.isPlaying {
                    p.play()
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "The sound files could not be loaded. You want to try deleting the application and reainstalling it if this happens again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {[weak self] action in
                self?.performSegue(withIdentifier: "back_to_menu", sender: self)
            }))
            self.present(alert, animated: true)
        }
        
    }
    
    @IBAction func nextQuestionBtnTpd(_ sender: UIButton) {
        self.updateUI()
        self.setUpPlayer()
    }
    
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    

    // UI setup functions
    private func setupUI() {
        // set up the button titles
        let choices = quiz.currentQuestion.possibleAnswers
        for (index, button) in answerButtons!.enumerated() {
            button.setTitle(choices[index], for: UIControlState.normal)
        }
        intervalLbl.text = ""
        nextQuestionBtn.isHidden = true
        correctScoreLbl.text = "0"
        incorrectScoreLbl.text = "0"
        
        // setup rounded corners
        playBtn.layer.cornerRadius = Constants.cornerRadius
        nextQuestionBtn.layer.cornerRadius = Constants.cornerRadius
        quitBtn.layer.cornerRadius = Constants.cornerRadius
        
        // set up shadows
        setupShadow(targetView: topView)
        setupShadow(targetView: nextQuestionBtn)
        setupShadow(targetView: quitBtn)
        for button in answerButtons {
            setupShadow(targetView: button)
            button.layer.cornerRadius = Constants.cornerRadius
            // There was something you could do with a bezier path that would improve performance?
        }
    }
    
    private func updateUI() {  // for when a question is answered and it is time to reset the UI
        correctScoreLbl.text = String(quiz.correctAnswers)
        incorrectScoreLbl.text = String(quiz.wrongAnswers)
        
        for (index, button) in answerButtons!.enumerated() {
            button.backgroundColor = UIColor.white
            button.isEnabled = true
            let title = quiz.currentQuestion.possibleAnswers[index]
            button.setTitle(title, for: UIControlState.normal)
        }
        
        nextQuestionBtn.isHidden = true
        intervalLbl.text = ""
    }
    
    
    private func addShadowForButton(view: UIView, button: UIButton, opacity: Float = 1) {
        let shadow = UIView()
        self.playBtnShadow = shadow
        shadow.backgroundColor = UIColor(cgColor: Constants.shadowColor)
        shadow.layer.opacity = Constants.shadowOpacity
        shadow.layer.shadowRadius = Constants.shadowRadius
        shadow.layer.shadowOpacity = Constants.shadowOpacity
        shadow.layer.shadowOffset = Constants.shadowOffset
        shadow.layer.cornerRadius = Constants.cornerRadius
        shadow.frame = CGRect(origin: CGPoint(x: button.frame.origin.x, y: button.frame.origin.y), size: CGSize(width: button.bounds.width, height: button.bounds.height))
        self.view.addSubview(shadow)
        view.bringSubview(toFront: button)
    }
    
    private func setupShadow(targetView: UIView) {
        targetView.layer.shadowColor = Constants.shadowColor
        targetView.layer.shadowOpacity = Constants.shadowOpacity
        targetView.layer.shadowRadius = Constants.shadowRadius
        targetView.layer.shadowOffset = Constants.shadowOffset
    }
    
    
    // Functions to setup the audio players for playing the intervals
    private func setUpPlayer() {
        
        if let path = Bundle.main.path(forResource: quiz.currentQuestion.startNoteFile, ofType: "m4a", inDirectory: "short_notes"), let path2 = Bundle.main.path(forResource: quiz.currentQuestion.endNoteFile, ofType: "m4a", inDirectory: "short_notes") {

            let url = URL(fileURLWithPath: path)
            let url2 = URL(fileURLWithPath: path2)
            
            do {
                
                // in case player has already been initialized and is playing
                if player != nil && (player?.isPlaying)! {
                    player?.stop()
                }
                player = try AVAudioPlayer(contentsOf: url)
                player!.delegate = self
                player!.volume = 1.0
                player!.prepareToPlay()
                
                // get second one ready
                if player2 != nil && (player2?.isPlaying)! {
                    player2?.stop()
                }
                player2 = try AVAudioPlayer(contentsOf: url2)
                player2!.volume = 1.0
                player2?.prepareToPlay()
                
                isPlayerSetUp = true
                
            } catch {
                // couldn't load file 
                print(error)
                isPlayerSetUp = false
            }
            
        } else {
            isPlayerSetUp = false
        }
    }
    
    // called when audio player has finished playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // play the next interval sound file
        if (!player2!.isPlaying) {
            player2!.play()
        }
    }
    
    
    enum Constants {
        static let shadowColor = UIColor.gray.cgColor
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 1.0
        static let shadowOffset = CGSize(width: 3, height: 3)
        static let cornerRadius: CGFloat = 5.0
        static let noShadowOpacity: Float = 0.0
    }
    
}

