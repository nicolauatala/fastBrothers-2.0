//
//  resultsViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 20/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Parse

class resultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //var myResults = [String]()
    
    var myChallenge = Challenge(id: "", name:"", password:"", turns: 0, especial: 0, WhoRegistered: PFUser.current()!, status: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        self.title = "Resultados"
        
        print(myChallenge.turns)
        print(myChallenge.especial)
        
        let getResults = Results()
        getResults.getPilotTimes(challenge:myChallenge.id,completionHandler: { (resultSave) -> Void in
            print("getResults")
            self.tableView.reloadData()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0: break
            //myResults.removeAll()
            //myResults = ["1º   |   E33   |   15:38:44", "2º   |   E33   |   15:38:44", "3º   |   E33   |   15:38:44", "4º   |   E33   |   15:38:44"]
            //tableView.reloadData()
        case 1: break
            //myResults.removeAll()
            //myResults = ["1º   |   E33   |   15:38:44", "2º   |   E33   |   15:38:44"]
            //tableView.reloadData()
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeResults.count
        //myResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for:  indexPath) as! challengeTableViewCell
        
        if indexPath.row % 2 == 0 {
            myCell.backgroundColor = UIColor.white
        } else {
            myCell.backgroundColor = UIColor.groupTableViewBackground
        }
       
        let string = String(indexPath.row+1) + "º | " + String(challengeResults[indexPath.row].pilot) + " | " + timePilot()
        
        myCell.resultsCell.text   = string
        
        return myCell as UITableViewCell
    }
    
    func timePilot() -> String{
        let time: UnixTime = ((myChallenge.especial * 1800) * myChallenge.turns)
        //var myMilliseconds: UnixTime = 1470075992

//        let generalTime = Date(timeIntervalSince1970: TimeInterval(time))
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
        
        return String(time.toHour)
    }

}

typealias UnixTime = Int

extension UnixTime {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self) + 10800)
    }
    var toHour: String {
        return formatType(form: "HH:mm:ss").string(from: dateFull)
    }
}

//print(myMilliseconds.toDay)
