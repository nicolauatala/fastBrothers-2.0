//
//  timerViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 20/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class timerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var timesTableView: UITableView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var times = [String]()
    
    let clock = Clock()
    var timer: Timer?
    
    var authentication = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timesTableView.tableFooterView = UIView()
        self.title = "Cronômetro"
        
        if authentication != true {
            self.checkPassword()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerViewController.updateTimeLabel), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTimeLabel()
    }
    
    func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        timerLabel.text = formatter.string(from: clock.currentTime as Date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        if let timer = self.timer {
            timer.invalidate()
        }
    }


    @IBAction func saveTheTime(_ sender: Any) {
        times.append(timerLabel.text!)
        timesTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "timerCell", for:  indexPath) as! challengeTableViewCell
        
        if indexPath.row % 2 == 0 {
            myCell.backgroundColor = UIColor.white
        } else {
            myCell.backgroundColor = UIColor.groupTableViewBackground
        }
        
        myCell.time.text   = times[indexPath.row]
        return myCell as UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            times.remove(at: indexPath.row)
            timesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("Select row at index \(indexPath.row)")
        
        let alertController = UIAlertController( title: "Atenção",
                                                 message: "Digite o número completo do piloto",
                                                 preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let destroyAction = UIAlertAction(title: "Salvar", style: .default) { action in
            print("Save time")
            self.times.remove(at: indexPath.row)
            self.timesTableView.reloadData()
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Número do piloto"
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(destroyAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if times.count != 0 {
           title = "Informe o número do piloto"
        }
        return title
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
        
        let forgotPasswordAction = UIAlertAction(title: "Solicitar acesso", style: .destructive)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            print("Cancel")
            self.navigationController?.popToRootViewController(animated: true)
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
        
        alertController.addAction(loginAction)
        alertController.addAction(forgotPasswordAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
}
