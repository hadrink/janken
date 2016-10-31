//
//  PlayerView.swift
//  Janken
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import Foundation
import UIKit

class PlayerView: UIView {
    
    //-- Global var
    unowned var newGame: Janken
    var player: JankenPlayer
    var playerNameLabel: UILabel
    var chooseYourWeaponLabel: UILabel
    var weaponChooseLabel: UILabel
    var weaponCollection: UICollectionView
    var validateButton: UIButton
    var weaponsAvailables: Array<Weapon> = []
    
    init(frame: CGRect, newGame: Janken, player: JankenPlayer) {
        
        //-- Set global var
        self.newGame = newGame
        self.player = player
        self.playerNameLabel = UILabel()
        self.chooseYourWeaponLabel = UILabel()
        self.weaponChooseLabel = UILabel()
        self.validateButton = UIButton()
        
        //-- Collection View needs a Layout
        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionLayout.itemSize = CGSize(width: 80, height: 80)
        collectionLayout.minimumLineSpacing = 10
        self.weaponCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionLayout)
        
        //-- Init superclass
        super.init(frame: frame)
        
        //-- Add action to validateButton
        self.validateButton.addTarget(self, action: #selector(self.validateAction(sender:)), for: .touchUpInside)
        
        //-- Delegate & Datasource for weaponCollection
        self.weaponCollection.dataSource = self
        self.weaponCollection.delegate = self
        
        //-- Display elements in view
        self.structureView()
        
        //-- Get weapons
        self.getWeaponsAvailables()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func getWeaponsAvailables() {
        guard let weapons = newGame.weapons else {
            return
        }
        
        for weapon in weapons {
            self.weaponsAvailables.append(weapon)
        }
    }
    
    internal func validateAction(sender: UIButton) {
        
        if self.player.id == newGame.players?.last?.id {
            //-- All players played. Definie winners
            self.newGame.referee.defineWinners(players: self.newGame.players!)
        }
        
        //-- Remove this view
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
            }, completion: { completed in
                self.removeFromSuperview()
        })
    }
    
    internal func structureView() {
        
        //-- This view
        self.backgroundColor = UIColor.white
        self.alpha = 0.0
        
        //-- Player name label
        self.playerNameLabel.text = player.name
        self.playerNameLabel.textColor = Design.colors.lightBlue
        self.playerNameLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.playerNameLabel.sizeToFit()
        self.playerNameLabel.frame.origin = CGPoint(x: self.frame.width / 2 - self.playerNameLabel.frame.width / 2, y: 100)
        self.addSubview(playerNameLabel)
        
        //-- Choose your weapon label
        self.chooseYourWeaponLabel.text = "Choose your weapon"
        self.chooseYourWeaponLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        self.chooseYourWeaponLabel.sizeToFit()
        self.chooseYourWeaponLabel.frame.origin = CGPoint(x: self.frame.width / 2 - self.chooseYourWeaponLabel.frame.width / 2, y: self.playerNameLabel.frame.origin.y + self.playerNameLabel.frame.height + 20)
        self.addSubview(chooseYourWeaponLabel)
        
        //-- Validate Button
        Design.button(button: self.validateButton, callToAction: true)
        self.validateButton.frame = CGRect(x: 20, y: self.frame.height - 20 - 50, width: self.frame.width - 40, height: 50)
        self.validateButton.setTitle("Validate", for: .normal)
        self.addSubview(validateButton)
        
        //-- Weapon collection
        self.weaponCollection.frame = CGRect(x: 0, y: self.validateButton.frame.origin.y - self.validateButton.frame.height - 20 - 50, width: self.frame.width, height: 100)
        self.weaponCollection.register(WeaponCollectionCell.self, forCellWithReuseIdentifier: "weapon_collection_cell")
        self.weaponCollection.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        self.addSubview(weaponCollection)
    
        //-- Weapon choose label
        self.weaponChooseLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.weaponChooseLabel.frame = CGRect(x: 0, y: self.weaponCollection.frame.origin.y - 60, width: self.frame.width, height: 40)
        self.weaponChooseLabel.textAlignment = .center
        self.addSubview(weaponChooseLabel)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
        })
    }
}

extension PlayerView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //-- Return nb weapons
        return weaponsAvailables.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //-- Create cell
        let collectionViewCell: WeaponCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weapon_collection_cell", for: indexPath) as! WeaponCollectionCell
        collectionViewCell.weapon = weaponsAvailables[indexPath.row]
        
        //-- Pre-select the first cell
        if !collectionViewCell.isSelected && indexPath.row == 0 {
            self.player.weaponChoose = weaponsAvailables[0]
            self.weaponChooseLabel.text = weaponsAvailables[0].name
            collectionViewCell.layer.borderWidth = 4
            collectionViewCell.layer.borderColor = Design.colors.blue.cgColor
        }
        
        return collectionViewCell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //-- Change text and add borders for selected row
        self.player.weaponChoose = weaponsAvailables[indexPath.row]
        self.weaponChooseLabel.text = weaponsAvailables[indexPath.row].name
        
        for cell in collectionView.visibleCells {
            cell.layer.borderWidth = 0
        }
        
        collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 4
        collectionView.cellForItem(at: indexPath)?.layer.borderColor = Design.colors.blue.cgColor
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 0
    }
}

