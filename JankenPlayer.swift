//
//  JankenPlayer.swift
//  Janken
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import Foundation
import UIKit

protocol JankenPlayerProtocol {
    var weaponChoose: Weapon? {get set}
}

class JankenPlayer: JankenPlayerProtocol {
    var id: String
    var name: String
    var weaponChoose: Weapon?
    
    init(name: String?) {
        self.id = UUID().uuidString
        self.name = name!
    }
}
