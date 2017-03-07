//
//  PilotTime.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 04/03/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import Parse

var recordsTime = [PilotTime]()

class PilotTime {
    
    var challenge = ""
    var especial = 0
    var gate = 0
    var lap = 0
    var time = 0.0
    var pilot = ""
    
    init(challenge: String, especial:Int, gate: Int, lap:Int, time: Double, pilot: String) {
        self.challenge = challenge
        self.especial = especial
        self.gate = gate
        self.lap = lap
        self.time = time
        self.pilot = pilot
    }
    
    func saveTime(PilotTime: PilotTime) {
        print("Salvo")
        let saveTime = PFObject(className:"PilotTime")
        saveTime["challenge"] = PilotTime.challenge
        saveTime["especial"] = PilotTime.especial
        saveTime["gate"] = PilotTime.gate
        saveTime["lap"] = PilotTime.lap
        saveTime["time"] = PilotTime.time
        saveTime["pilot"] = PilotTime.pilot
        saveTime.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print("Challenge Saved")
            } else {
                print("Challenge not save")
            }
        }
    }
    
    func getAllRecords(challenge:String, completionHandler:@escaping (Bool) -> ()) {
        print("ID Challenge: \(challenge)")
        let query = PFQuery(className:"PilotTime")
        query.whereKey("challenge", equalTo: challenge)
        query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    recordsTime.removeAll()
                    for object in objects {
                        let newRecord = PilotTime(
                            challenge: object["challenge"] as! String,
                            especial: object["especial"] as! Int,
                            gate: object["gate"] as! Int,
                            lap: object["lap"] as! Int,
                            time: object["time"] as! Double,
                            pilot: object["pilot"] as! String)
                        
                        recordsTime.append(newRecord)
                        
                        print("PilotTime adicionado")
                    }
                }
                completionHandler(true)
            } else {
                print("Error: \(error!) \(error!)")
            }
        }
    }
    
}

//TimeOfPilot:
//challengeId
//whereLocation
//time
//numberOfPilot
//
//Calculate timeOfPilot
