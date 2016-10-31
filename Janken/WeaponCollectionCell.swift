//
//  WeaponCollectionCell.swift
//  Janken
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import Foundation
import UIKit

class WeaponCollectionCell: UICollectionViewCell {
    
    //-- Load image when weapon is set
    var weapon: Weapon? {
        didSet {
            let imageView = UIImageView()
            imageView.image = weapon?.image
            imageView.frame.size = CGSize(width: 60, height: 60)
            self.backgroundView = imageView
            self.backgroundView?.frame.size = CGSize(width: 60, height: 60)
            self.backgroundView?.frame.origin = CGPoint(x: 10, y: 10)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.structureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func structureView() {
        self.layer.cornerRadius = 8.0
        self.backgroundColor = Design.colors.lightBlue
    }
}
