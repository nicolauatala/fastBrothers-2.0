//
//  recordOfChallengeTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 17/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class recordOfChallengeTableViewController: UITableViewController {
    
    let records = ["14:29:44","14:30:54","14:41:29","14:42:44"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for:  indexPath) as! challengeTableViewCell
        
        myCell.recordCell.text   = records[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            myCell.backgroundColor = UIColor.white
        } else {
            myCell.backgroundColor = UIColor.groupTableViewBackground
        }
        
        return myCell as UITableViewCell
    }

}
