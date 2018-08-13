//
//  StatsTableViewCell.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 8/1/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var intervalTitleLbl: UILabel!
    @IBOutlet weak var intervalDetailLbl: UILabel!
    @IBOutlet weak var intervalPercentLbl: UILabel!
    @IBOutlet weak var intervalCardView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.intervalPercentLbl.adjustsFontSizeToFitWidth = true
        self.intervalDetailLbl.adjustsFontSizeToFitWidth = true
        self.intervalTitleLbl.adjustsFontSizeToFitWidth = true
        
        self.intervalCardView.layer.cornerRadius = Constants.cornerRadius
        setupShadow(targetView: self.intervalCardView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // UI setup
    private func setupShadow(targetView: UIView) {
        targetView.layer.shadowColor = Constants.shadowColor
        targetView.layer.shadowOpacity = Constants.shadowOpacity
        targetView.layer.shadowRadius = Constants.shadowRadius
        targetView.layer.shadowOffset = Constants.shadowOffset
    }
    
    
    enum Constants {
        static let shadowColor = UIColor.gray.cgColor
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 1.0
        static let shadowOffset = CGSize(width: 3, height: 3)
        static let cornerRadius: CGFloat = 5.0
    }


}
