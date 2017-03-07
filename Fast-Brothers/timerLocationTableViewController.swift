//
//  timerLocationTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 22/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Parse

class timerLocationTableViewController: UITableViewController {
    
    var myChallenge = Challenge(id: "", name:"", password:"", turns: 0, especial: 0, WhoRegistered: PFUser.current()!, status: "")
    var numberLocations = 0
    var arrayLocal = [String]()
    var authentication = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if authentication != true {
            self.checkPassword()
        }
        
        
        print("_______________________")
        print("My Challenge: \(myChallenge.name)")
        print("My ChallengeID: \(myChallenge.id)")
        print("My Challenge turns: \(myChallenge.turns)")
        print("My Challenge especial: \(myChallenge.especial)")
        
        for index in 1...myChallenge.especial{
            arrayLocal.append("Especial \(index) - Entrada")
            arrayLocal.append("Especial \(index) - Saída")
        }
        
        self.tableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLocal.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "localCell", for:  indexPath) as! challengeTableViewCell
        myCell.local.text   = arrayLocal[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            myCell.local.textColor = UIColor(red: 24/255, green: 218/255, blue: 87/255, alpha: 1)
        } else {
            myCell.local.textColor = UIColor(red: 226/255, green: 71/255, blue: 19/255, alpha: 1)
        }
        
        return myCell as UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Local onde ficará posicionado"
    }

    func checkPassword(){
        //let nameChallenge = challengesByClass[indexPath.row].name
        
        let alertController = UIAlertController(title: "Atenção", message: "Informe a senha de acesso da prova", preferredStyle: .alert)
        
        let loginAction = UIAlertAction(title: "Entrar", style: .default) { [weak alertController] _ in
            if let alertController = alertController {
                _ = alertController.textFields![0] as UITextField
                //let passwordTextField = alertController.textFields![1] as UITextField
                //login(loginTextField.text, passwordTextField.text)
                
                //let loggedPage = self.storyboard?.instantiateViewController(withIdentifier: "timerViewController") as! timerViewController
                //let loggedPageNav = UINavigationController (rootViewController: loggedPage)
                //let appDelegate   = UIApplication.shared.delegate as! AppDelegate
                //appDelegate.window?.rootViewController = loggedPageNav
            }
        }
        loginAction.isEnabled = false
        
//        let requestAccess = UIAlertAction(title: "Solicitar acesso", style: .default) { action in
//            print("Solicitado")
//            _ = self.navigationController?.popToRootViewController(animated:true)
//        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive) { action in
            print("Cancel")
            _ = self.navigationController?.popToRootViewController(animated:true)
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Senha de acesso"
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { notification in
                loginAction.isEnabled = textField.text != ""
            }
        }
        
        //alertController.addTextField { textField in
        //textField.placeholder = "Password"
        //.isSecureTextEntry = true
        //}
        
        //alertController.view.tintColor = UIColor.black
        
        alertController.addAction(loginAction)
        //alertController.addAction(requestAccess)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTimerSegue" {
            let nextScene =  segue.destination as! timerViewController
            
            nextScene.challengeID = myChallenge.id
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                print("Index row selected: \(indexPath.row)")
                
                if indexPath.row % 2 == 0 {
                    print("entrada")
                } else {
                    print("saida")
                }
                
            }

        }
    }
}
