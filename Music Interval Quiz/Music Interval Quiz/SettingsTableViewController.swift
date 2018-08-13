//
//  SettingsTableViewController.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 7/29/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let intervalNames = ["P1", "m2", "M2", "m3", "M3", "P4", "Tritone", "P5", "m6", "M6", "m7", "M7", "P8"]
    let saveTool = SaveTool()
    lazy var selectedIntervals : [String] = saveTool.getIntervals()

    @IBAction func saveBtnTpd(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Save", message: "Are you sure you want to save these new settings?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            // save the new settings
            self?.saveTool.saveIntervals(intervals: (self?.selectedIntervals)!)
            self?.performSegue(withIdentifier: "UnwindFromSettingsToMenu", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            // do nothing
        }))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 242/255, alpha: 1.0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return intervalNames.count
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Tested Intervals"
        }
        return "Error"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! IntervalSettingsTableViewCell
        
        let title = intervalNames[indexPath.row]
        cell.intervalLbl.text = title
        cell.intervalSwitch.isOn = selectedIntervals.contains(title)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.callback = { [weak self] (selected) in
            if (selected) {
                // just selected it - add to the array
                self?.selectedIntervals.append(title)
            } else {
                // just deleselcted it - remove it from the array
                for (index, item) in (self?.selectedIntervals.enumerated())! {
                    if item == title {
                        self?.selectedIntervals.remove(at: index)
                    }
                }
            }
        }
    
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 242/255, alpha: 1.0)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
 

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
