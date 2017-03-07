//
//  recordTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 17/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Parse

class recordTableViewController: UITableViewController {

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registro"
        tableView.tableFooterView = UIView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        recordsTime.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Veja todos os registros do cronometro"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengesObjs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "challengeCell", for:  indexPath) as! challengeTableViewCell
        
        myCell.nameChallenge.text   = challengesObjs[indexPath.row].name
        
        //let numberReg = ((indexPath.row + 1) * challengesObjs[indexPath.row].turns) * challengesObjs[indexPath.row].especial
        //myCell.descriptionChallenge.text = "Total de registros \(numberReg)"
        myCell.descriptionChallenge.text = ""
        
        return myCell as UITableViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toRecordsSegue" {
            let nextScene =  segue.destination as! recordOfChallengeTableViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedVehicle = challengesObjs[indexPath.row]
                nextScene.myChallenge = selectedVehicle
            }
        }
    }

}
