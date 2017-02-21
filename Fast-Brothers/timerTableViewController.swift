//
//  timerTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 06/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class timerTableViewController: UITableViewController {

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cronometro"
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengesByClass.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "challengeCell", for:  indexPath) as! challengeTableViewCell
        
        myCell.nameChallenge.text   = challengesByClass[indexPath.row].name
        
         let description = "Voltas: " + String(challengesByClass[indexPath.row].turns) + ", Especial: " + String(challengesByClass[indexPath.row].especial)
        myCell.descriptionChallenge.text = description
        
        if indexPath.row == 0 {
            myCell.lockIcon.image = #imageLiteral(resourceName: "deslock")
        }
        
        return myCell as UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.backgroundColor = UIColor(red: 252/255, green: 245/255, blue: 85/255, alpha: 1)
        //240,255,80
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Selecione um prova"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timerSegue" {
            let nextScene =  segue.destination as! timerViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //let selectedVehicle = vehicles[indexPath.row]
                if indexPath.row == 0 {
                    nextScene.authentication = true
                }
            }
        }
    }

}
