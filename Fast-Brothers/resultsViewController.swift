//
//  resultsViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 20/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class resultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var myResults = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        self.title = "Resultados"
        
        myResults = ["E3", "222G", "F11", "007"]
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            myResults.removeAll()
            myResults = ["1º   |   E33   |   15:38:44", "2º   |   E33   |   15:38:44", "3º   |   E33   |   15:38:44", "4º   |   E33   |   15:38:44"]
            tableView.reloadData()
        case 1:
            myResults.removeAll()
            myResults = ["1º   |   E33   |   15:38:44", "2º   |   E33   |   15:38:44"]
            tableView.reloadData()
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for:  indexPath) as! challengeTableViewCell
        
        if indexPath.row % 2 == 0 {
            myCell.backgroundColor = UIColor.white
        } else {
            myCell.backgroundColor = UIColor.groupTableViewBackground
        }
        
        myCell.resultsCell.text   = myResults[indexPath.row]
        
        return myCell as UITableViewCell
    }

}
