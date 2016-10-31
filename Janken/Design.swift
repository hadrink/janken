//
//  Design.swift
//  Janken
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import Foundation
import UIKit

struct Design {
    
    static func button(button: UIButton, callToAction: Bool) {
        
        if callToAction {
            button.backgroundColor = self.colors.blue
        } else {
            button.backgroundColor = self.colors.lightBlue
        }
        
        button.layer.cornerRadius = 8.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    struct colors {
        
        internal static func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        
        //-- Soome colors
        static let lightBlue: UIColor = UIColorFromRGB(0x77A4DD)
        static let blue: UIColor = UIColorFromRGB(0x126FBD)
    }
}
