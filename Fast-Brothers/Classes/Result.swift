//
//  Result.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 05/03/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import Parse

var challengeResults = [Result]()

class Results {
    func getPilotTimes(challenge:String, qntdEspecial: Int, turn: Int, completionHandler:@escaping (Bool) -> ()) {
        
        let query = PFQuery(className:"PilotTime")
        query.whereKey("challenge", equalTo: challenge)
        query.order(byAscending: "createdAt")
        query.order(byAscending: "pilot")
        //query.order(byAscending: "gate")
        query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    
                    challengeResults.removeAll()
                    
                    var index = 0
                    let especial = (qntdEspecial * 2) - 1
                    
                    let timePilot1 = timePilot()
                    let timePilot2 = timePilot()
                    
                    repeat {
                        print("Index: \(index)")
                        var theEspecial = 0
                        if index > 0{
                            theEspecial = (index/2)+1
                            print("__________Especial: \(theEspecial)__________")
                        } else {
                            theEspecial = index + 1
                            print("__________Especial: \(theEspecial)__________")
                        }
                        
                        for object in objects {
                            let pilotObject = Result()
                            pilotObject.especial = object["especial"] as! Int
                            pilotObject.gate     = object["gate"] as! Int
                            pilotObject.pilot    = object["pilot"] as! String
                            pilotObject.time     = object["time"] as! Double
                            
                            //for n in 0...1{
                            if  (pilotObject.especial == index) || (pilotObject.especial == index+1) {
                                let time: UnixTime = object["time"] as! Int
                                
                                print("Especial: \(pilotObject.especial) | gate: \(pilotObject.gate) | piloto: \(pilotObject.pilot) | time: \(time.toHour)")
                                
                                if pilotObject.gate == 0 {
                                    timePilot1.pilot = pilotObject.pilot
                                    timePilot1.time = Double(time)
                                } else {
                                    timePilot2.pilot = pilotObject.pilot
                                    timePilot2.time = Double(time)
                                }
                                //print("time 1: \(timePilot1.time)")
                                //print("time 2 :\(timePilot2.time)")
                            }
                            //}
                            
                            let newResult = Result()
                            newResult.pilot = timePilot1.pilot
                            newResult.time = 0.0
                            
                            if timePilot2.time != 0.0{
                                if timePilot1.pilot == timePilot2.pilot{
                                    
                                    let dif = timePilot2.time - timePilot1.time
                                    
                                    if (dif > 0) && (dif < 1800) {

                                        newResult.pilot = timePilot1.pilot
                                        newResult.time = dif
                                        
                                        newResult.addToResults(pilot: newResult.pilot, time: newResult.time, qntdEspecial: qntdEspecial, turn: turn)
                                    }
                                    
                                } else {
                                    
                                    newResult.addToResults(pilot: newResult.pilot, time: newResult.time, qntdEspecial: qntdEspecial, turn: turn)

                                }
                            }
                            else {
                                //if not have timePilot2
                                //print("if not have timePilot2")
                                //print("pilot \(newResult.pilot)")
                                //print("pilot \(newResult.time)")
                                
                                newResult.addToResults(pilot: newResult.pilot, time: newResult.time, qntdEspecial: qntdEspecial, turn: turn)
                            }
                            
                        }
                        
                        index += 2
                        
                    } while especial != index - 1 //end Index turn
                }
                completionHandler(true)
            }
        }
    }
}

class timePilot {
    var pilot = ""
    var time = 0.0
}

class Result {
    
    var pilot = ""
    var time = 0.0
    var especial = 0
    var gate = 0
    //var turn = 0
    
    func addToResults(pilot:String, time: Double, qntdEspecial: Int, turn: Int){
        let newResult = Result()
        newResult.pilot = pilot
        newResult.time = time
        
        if challengeResults.contains(where: { $0.pilot == newResult.pilot }) {
            //print("existente")
            if let i = challengeResults.index(where: { $0.pilot == newResult.pilot }) {
                if challengeResults[i].time > 1800{
                    challengeResults[i].time -= 1800.0 - newResult.time
                }
            }
        } else {
            //adiciona primeiro valor
            let initialTime = Double(qntdEspecial * turn) * 1800.0
            
            if newResult.time == 0.0 {
                //print("adiciona \(initialTime)")
                newResult.time = initialTime
            } else {
                //print("calculo")
                //print(initialTime)
                //print(newResult.time)
                newResult.time = initialTime - (1800.0 - newResult.time)
            }

            challengeResults.append(newResult)
        }
        
    }
    
}
