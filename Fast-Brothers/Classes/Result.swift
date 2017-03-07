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
    func getPilotTimes(challenge:String, completionHandler:@escaping (Bool) -> ()) {
        let query = PFQuery(className:"PilotTime")
        query.whereKey("challenge", equalTo: challenge)
        query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    challengeResults.removeAll()
                    for object in objects {
                        
                        let newResult = Result()
                        newResult.pilot = object["pilot"] as! String
                        newResult.generalTime = object["time"] as! Double
                        
                        if challengeResults.contains(where: { $0.pilot == newResult.pilot }) {
                            print("existente")
                        } else{
                            print("adicionado")
                            challengeResults.append(newResult)
                        }
                        
                    }
                }
                completionHandler(true)
            } else {
                print("Error: \(error!) \(error!)")
            }
        }
    }
}

class Result {
    
    var pilot = ""
    var generalTime = 0.0
    
}
