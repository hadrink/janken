//
//  Janken.swift
//  Janken
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import Foundation

protocol JankenProtocol {
    var weapons: Array<Weapon>? {get set}
    var players: Array<JankenPlayer>? {get set}
    var referee: Referee {get}
}

class Janken: JankenProtocol {
    var weapons: Array<Weapon>?
    var players: Array<JankenPlayer>?
    var referee: Referee = Referee()
    
    deinit {
        print("Game Over")
    }
}
