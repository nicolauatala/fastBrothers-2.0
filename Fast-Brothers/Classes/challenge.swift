//
//  challenge.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 17/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import Foundation
import Parse

var challengesByClass:[Challenge] = []

class Challenge {
    let name: String
    let password: String
    let turns: Int
    let especial: Int
    let ch: Int
    let WhoRegistered: PFUser
    var status = "Em andamento"
    
    
    init(name: String, password: String, turns: Int, especial: Int, ch: Int, WhoRegistered: PFUser) {
        self.name = name
        self.password = password
        self.turns = turns
        self.especial = especial
        self.ch = ch
        self.WhoRegistered = WhoRegistered
    }
    
    
}
