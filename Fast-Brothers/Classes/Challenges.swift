//
//  Challenges.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 20/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import Parse
import ParseUI

var challengesObjs:[Challenge] = []
var PFChallenges:[PFObject] = []

class Challenges {
    
    func updataChallenges(completionHandler:@escaping (Bool) -> ()) {
        let query = PFQuery(className:"Challenges")
        query.findObjectsInBackground {
            (objects:[PFObject]?, error:Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    challengesObjs.removeAll()
                    for object in objects {
                        let newChallenge = Challenge(
                            id: object.objectId!,
                            name: object["name"] as! String,
                            password: object["password"] as! String,
                            turns: object["turns"] as! Int,
                            especial: object["especial"] as! Int,
                            WhoRegistered: object["whoRegistered"] as! PFUser,
                            status: object["status"] as! String)
                        
                        challengesObjs.append(newChallenge)
                        print("Objeto adicionado")
                    }
                }
                completionHandler(true)
            } else {
                print("Error: \(error!) \(error!)")
            }
        }
    }
    
    func saveChallenge(challenge: Challenge){
        let newChallenge = PFObject(className:"Challenges")
        newChallenge["name"] = challenge.name
        newChallenge["password"] = challenge.password
        newChallenge["turns"] = challenge.turns
        newChallenge["especial"] = challenge.especial
        newChallenge["whoRegistered"] = challenge.whoRegistered
        newChallenge["status"] = challenge.status
        newChallenge.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print("Challenge Saved")
            } else {
                print("Challenge not save")
            }
        }
    }
    
    func countChallengesByThisUser(completionHandler:@escaping (Int) -> ()) {
        let query = PFQuery(className:"Challenges")
        query.whereKey("whoRegistered", equalTo: PFUser.current()!)
        query.findObjectsInBackground {
            (objects:[PFObject]?, error:Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    completionHandler(objects.count)
                } else {
                    completionHandler(0)
                }
            }
        }
    }
}

class Challenge {
    let id: String
    let name: String
    let password: String
    let turns: Int
    let especial: Int
    let whoRegistered: PFUser
    let status: String //Em andamento ou Finalizado
    
    
    init(id: String, name: String, password: String, turns: Int, especial: Int, WhoRegistered: PFUser, status: String) {
        self.id = id
        self.name = name
        self.password = password
        self.turns = turns
        self.especial = especial
        self.whoRegistered = WhoRegistered
        self.status = status
    }
    
}

