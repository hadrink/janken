//
//  ResultView.swift
//  Janken
//
//  Created by Rplay on 31/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import Foundation
import UIKit

class ResultView: UIView {
    var players: Array<JankenPlayer>
    var winners: Array<JankenPlayer>?
    var resultLabel: UILabel
    var goBackButton: UIButton
    
    init(frame: CGRect, players: Array<JankenPlayer>, winners: Array<JankenPlayer>?) {
        self.players = players
        self.winners = winners
        self.resultLabel = UILabel()
        self.goBackButton = UIButton()
        
        super.init(frame: frame)
        
        self.structureView()
        self.displayWinners()
        
        self.goBackButton.addTarget(self, action: #selector(self.goBackButtonAction(sender:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func structureView() {
        
        //-- View
        self.backgroundColor = UIColor.white
        
        //-- Result label
        self.resultLabel.font = UIFont.italicSystemFont(ofSize: 24.0)
        self.resultLabel.frame = CGRect(x: 0, y: 100, width: self.frame.width, height: 40)
        self.addSubview(self.resultLabel)
        
        
        //-- Go back button
        let goBackButtonHeight: CGFloat = 50.0
        let margin: CGFloat = 20
        self.goBackButton.frame = CGRect(x: margin, y: self.frame.height - goBackButtonHeight - margin, width: self.frame.width - margin * 2, height: goBackButtonHeight)
        self.goBackButton.setTitle("Menu", for: .normal)
        Design.button(button: self.goBackButton, callToAction: true)
        self.addSubview(self.goBackButton)
    }
    
    internal func displayWinners() {
        
        //-- For each player we display his choice
        let contentPlayerView = UIView()
        let playerViewSize = CGSize(width: 90, height: 120)
        var playerViewOriginX: CGFloat = 0.0
        
        for player in players {
            
            //-- Create playerView to insert into contentPlayerView
            let playerView = UIView()
            playerView.frame = CGRect(x: playerViewOriginX, y: 0, width: playerViewSize.width, height: playerViewSize.width)
            
            //-- Create imageView and name to insert into playerView
            let imageView = UIImageView()
            imageView.image = player.weaponChoose?.image
            imageView.frame.size = CGSize(width: 80, height: 80)
            imageView.frame.origin = CGPoint(x: 5, y: 0)
            
            let name = UILabel()
            name.text = player.name
            name.frame.size = CGSize(width: playerViewSize.width, height: 20)
            name.frame.origin = CGPoint(x: 0, y: imageView.frame.origin.y + imageView.frame.height + 10)
            name.textAlignment = .center
            name.font = UIFont.systemFont(ofSize: 11)
            
            playerView.addSubview(imageView)
            playerView.addSubview(name)
            contentPlayerView.addSubview(playerView)
            
            //-- Inc X position to place one next to other
            playerViewOriginX += playerViewSize.width
        }
        
        //-- Display contentPlayerView
        self.addSubview(contentPlayerView)
        contentPlayerView.frame.size = CGSize(width: playerViewSize.width * CGFloat(players.count), height: playerViewSize.height)
        contentPlayerView.frame.origin = CGPoint(x: self.frame.width / 2 - contentPlayerView.frame.width / 2, y: self.resultLabel.frame.origin.y + self.resultLabel.frame.height + 20)
        
        //-- If winners is nil it's a draw
        guard let winners = winners else {
            self.resultLabel.text = "It's a draw !"
            self.resultLabel.textAlignment = .center
            return
        }
        
        var winnersName: Array<String> = []
        
        for winner in winners {
            winnersName.append(winner.name)
        }
        
        var label: String = ""
        
        for winnerName in winnersName {
            label += "\(winnerName) "
        }
        
        self.resultLabel.text = label + "win !"
        self.resultLabel.textAlignment = .center
    }
    
    internal func goBackButtonAction(sender: UIButton) {
        
        //-- Remove this view to show the menu
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
        }, completion: { completed in
            self.removeFromSuperview()
        })
    }
}
