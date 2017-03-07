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
    var timesDouble = [Double]()
    var challengeID = ""
    
    
    let clock = Clock()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timesTableView.tableFooterView = UIView()
        self.title = "Cronômetro"
        
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
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        let myTime = clock.currentTime.timeIntervalSince1970
        print("________")
        print(formatter.string(from: clock.currentTime as Date))
        print(Int(myTime))
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        let hour = Double(components.hour!)
        let minutes = Double(components.minute!)
        let seconds = Double(components.second!)
        
        let currentTime: Double = (hour * 3600) + (minutes * 60) + seconds
        print("Current time: \(currentTime)")
        
        //let myNSDate = Date(timeIntervalSince1970: currentTime)
        //print(myNSDate)
        
        times.append(timerLabel.text!)
        timesDouble.append(currentTime)
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
        
        let alertController = UIAlertController( title: "Atenção",
                                                 message: "Digite o número completo do piloto",
                                                 preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let saveAction = UIAlertAction(title: "Salvar", style: .default) { action in
            
            if let alertTextField = alertController.textFields?.first, alertTextField.text != nil {
                print("Numero do piloto: \(alertTextField)")
                let pilotTime = PilotTime(challenge: self.challengeID, especial: 0, gate: 0, lap: 0, time: Double(self.timesDouble[indexPath.row]), pilot: alertTextField.text!)
                
                pilotTime.saveTime(PilotTime: pilotTime)
            }
            
            
            print(self.timesDouble[indexPath.row])
            self.times.remove(at: indexPath.row)
            self.timesTableView.reloadData()
        }
        
        saveAction.isEnabled = false
        
        alertController.addTextField { textField in
            textField.placeholder = "Número do piloto"
            textField.keyboardType = .numberPad
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { notification in
                saveAction.isEnabled = (textField.text?.characters.count)! == 3
            }
        }
        
        alertController.addAction(saveAction)
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
    
    
}
