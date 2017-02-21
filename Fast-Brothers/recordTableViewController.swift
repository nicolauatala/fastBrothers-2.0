//
//  recordTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 17/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class recordTableViewController: UITableViewController {

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registro"
        tableView.tableFooterView = UIView()

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
        return challengesByClass.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "challengeCell", for:  indexPath) as! challengeTableViewCell
        
        myCell.nameChallenge.text   = challengesByClass[indexPath.row].name
        
        let numberReg = ((indexPath.row + 1) * challengesByClass[indexPath.row].turns) * challengesByClass[indexPath.row].especial
        myCell.descriptionChallenge.text = "Total de registros \(numberReg)"
        
        return myCell as UITableViewCell
    }

}
