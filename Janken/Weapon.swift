//
//  Weapon.swift
//  Janken
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import Foundation
import UIKit

protocol WeaponProtocol {
    var moreStrongerThan: Array<Weapon>? {get set}
}

class Weapon: WeaponProtocol {
    var name: String
    var image: UIImage?
    var moreStrongerThan: Array<Weapon>?
    
    init(name: String) {
        self.name = name
    }
}
