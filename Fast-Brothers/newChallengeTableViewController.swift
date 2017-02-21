//
//  newChallengeTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 06/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Parse

class newChallengeTableViewController: UITableViewController {
    
    @IBOutlet weak var voltasTextField: UITextField!
    @IBOutlet weak var especialTextField: UITextField!
    @IBOutlet weak var chTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func savaChallenge(_ sender: Any) {
        
        let newChallenge2 = Challenge(name: nameTextField.text!, password: passwordTextField.text!, turns: Int(voltasTextField.text!)!, especial: Int(especialTextField.text!)!, ch: Int(chTextField.text!)!, WhoRegistered: PFUser.current()!)
        
        challengesByClass.append(newChallenge2)
        print("Save!")
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func voltasStepper(_ sender: UIStepper) {
        let int = Int(sender.value)
        voltasTextField.text = String(int)
    }
    
    @IBAction func especialStepper(_ sender: UIStepper) {
        let int = Int(sender.value)
        especialTextField.text = String(int)
    }
    
    @IBAction func chStepper(_ sender: UIStepper) {
        let int = Int(sender.value)
        chTextField.text = String(int)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }


}