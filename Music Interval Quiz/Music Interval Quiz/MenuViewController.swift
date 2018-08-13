//
//  MenuViewController.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 3/27/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import UIKit

@IBDesignable
class MenuViewController: UIViewController {
    @IBOutlet weak var beginBtn: UIButton!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var statsBtn: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var highScoreLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    
    
    @IBAction func unwindFromQuizController(unwindSegue: UIStoryboardSegue) {
        displayHighScore()
    }
    
    @IBAction func unwindFromSettingsViewController(unwindSegue: UIStoryboardSegue) {
        displayHighScore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        displayHighScore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // UI setup
    private func setupUI() {
        
        // make text shrink to fit labels
        highScoreLbl.adjustsFontSizeToFitWidth = true
//        scoreLbl.lineBreakMode = .byClipping
//        scoreLbl.numberOfLines = 0

        welcomeLbl.adjustsFontSizeToFitWidth = true
        scoreLbl.adjustsFontSizeToFitWidth = true
        
        // round corners
        beginBtn.layer.cornerRadius = Constants.cornerRadius
        settingsBtn.layer.cornerRadius = Constants.cornerRadius
        statsBtn.layer.cornerRadius = Constants.cornerRadius
        scoreView.layer.cornerRadius = Constants.cornerRadius
        headerView.layer.cornerRadius = Constants.cornerRadius
        
        // set up view shadows
        setupShadow(targetView: headerView)
        setupShadow(targetView: beginBtn)
        setupShadow(targetView: settingsBtn)
        setupShadow(targetView: statsBtn)
        setupShadow(targetView: scoreView)
    }
    
    // UI setup
    private func setupShadow(targetView: UIView) {
        targetView.layer.shadowColor = Constants.shadowColor
        targetView.layer.shadowOpacity = Constants.shadowOpacity
        targetView.layer.shadowRadius = Constants.shadowRadius
        targetView.layer.shadowOffset = Constants.shadowOffset
    }
    
    
    private func displayHighScore() {
        let defaults = UserDefaults.standard
        let highScore = defaults.integer(forKey: "high_score")
        scoreLbl.text = String(highScore)
    }
    
    
    enum Constants {
        static let shadowColor = UIColor.gray.cgColor
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 1.0
        static let shadowOffset = CGSize(width: 3, height: 3)
        static let cornerRadius: CGFloat = 5.0
    }



}
