//
//  recordOfChallengeTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 17/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Parse

class recordOfChallengeTableViewController: UITableViewController {
    
    var myChallenge = Challenge(id: "", name:"", password:"", turns: 0, especial: 0, WhoRegistered: PFUser.current()!, status: "")
    
    //let records = ["14:29:44","14:30:54","14:41:29","14:42:44"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let getRecords = PilotTime(challenge: "", especial: 0, gate: 0, lap: 0, time: 0.0, pilot: "")
        getRecords.getAllRecords(challenge: myChallenge.id,completionHandler: { (resultSave) -> Void in
            print("getAllRecords complete")
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsTime.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for:  indexPath) as! challengeTableViewCell
        
        let generalTime = Date(timeIntervalSince1970: recordsTime[indexPath.row].time)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        
        var stringText = ""

        stringText += "Especial: \(String(recordsTime[indexPath.row].especial)) | " + formatter.string(from: generalTime)
        
        myCell.recordCell.text   = stringText
        
        if indexPath.row % 2 == 0 {
            myCell.backgroundColor = UIColor.white
        } else {
            myCell.backgroundColor = UIColor.groupTableViewBackground
        }
        
        return myCell as UITableViewCell
    }

}
