//
//  IntervalSettingsTableViewCell.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 7/29/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import UIKit

class IntervalSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var intervalSwitch: UISwitch!
    @IBOutlet weak var intervalLbl: UILabel!
    
    typealias SwitchCallBack = (Bool) -> Void
    var callback : SwitchCallBack?
    
    @IBAction func intervalSwitchChanged(_ sender: UISwitch) {
        callback?(sender.isOn)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        intervalSwitch.onTintColor = UIColor(displayP3Red: 0, green: 0.73, blue: 1.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
