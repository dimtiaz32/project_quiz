//
//  StatsTableViewController.swift
//  Music Interval Quiz
//
//  Created by Danish Imtiaz on 8/1/18.
//  Copyright © 2018 Danish Imtiaz. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {
    
    let intervalNames = ["P1", "m2", "M2", "m3", "M3", "P4", "Tritone", "P5", "m6", "M6", "m7", "M7", "P8"]
    var intervalStats : [IntervalStats]
    
    struct IntervalStats {
        var name : String
        var correct : Int
        var incorrect : Int
        var percent : Double {
            get {
                if (correct + incorrect) > 0 {
                    return Double(correct) / Double(correct + incorrect) * 100
                } else {
                    return 100.0
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.intervalStats = [IntervalStats]()
        
        // get the saved incorrect and correct values
        let saveTool = SaveTool()
        for interval in self.intervalNames {
            let correct = saveTool.getCorrectAnswers(forAnswer: interval)
            let incorrect = saveTool.getIncorrectAnswers(forAnswer: interval)
            let stat = IntervalStats(name: interval, correct: correct, incorrect: incorrect)
            intervalStats.append(stat)
        }
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 0/255, green: 187/255, blue: 255/255, alpha: 1.0)
        self.tableView.separatorStyle = .none
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
        return self.intervalNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath) as! StatsTableViewCell
        
        let stat = self.intervalStats[indexPath.row]
        cell.intervalTitleLbl.text = stat.name
        cell.intervalDetailLbl.text = "Correct: " + String(stat.correct) + " Incorrect: " + String(stat.incorrect)
        cell.intervalPercentLbl.text = String(format: "%.2f", stat.percent) + "%"
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 0/255, green: 187/255, blue: 255/255, alpha: 1.0)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
