//
//  ViewController.swift
//  Janken
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import UIKit
import Foundation

class JankenViewController: UIViewController {
    
    //-- Global var
    var playerVSPlayerButton: UIButton?
    var playerVSComputerButton: UIButton?
    var computerVSComputerButton: UIButton?
    var newGame: Janken?
    var weapons: Array<Weapon>?
    var playerView: PlayerView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //-- Display elements in view
        self.structureView()
        
        //-- Add actions for buttons
        self.addTargets()
        
        //-- Load weapons
        self.loadWeapons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func structureView() {
        
        //-- Init menu view
        let menuView: UIView = UIView()
        
        //-- Init playerVSPlayerButton
        self.playerVSPlayerButton = UIButton()
        self.playerVSPlayerButton?.frame = CGRect(x: 20, y: 0, width: self.view.frame.width - 40, height: 50)
        self.playerVSPlayerButton?.setTitle("Player VS Player", for: .normal)
        Design.button(button: playerVSPlayerButton!, callToAction: false)
        
        //-- Init playerVSComputerButton
        self.playerVSComputerButton = UIButton()
        self.playerVSComputerButton?.frame = CGRect(x: 20, y: self.playerVSPlayerButton!.frame.height + 20, width: self.view.frame.width - 40, height: 50)
        self.playerVSComputerButton?.setTitle("Player VS Computer", for: .normal)
        Design.button(button: playerVSComputerButton!, callToAction: false)
        
        //-- Init computerVSComputerButton
        self.computerVSComputerButton = UIButton()
        self.computerVSComputerButton?.frame = CGRect(x: 20, y: self.playerVSComputerButton!.frame.origin.y + self.playerVSComputerButton!.frame.height + 20, width: self.view.frame.width - 40, height: 50)
        self.computerVSComputerButton?.setTitle("Computer VS Computer", for: .normal)
        Design.button(button: computerVSComputerButton!, callToAction: false)
        
        //-- Add buttons to main view
        menuView.addSubview(self.playerVSPlayerButton!)
        menuView.addSubview(self.playerVSComputerButton!)
        menuView.addSubview(self.computerVSComputerButton!)
        
        //-- Display menu to the right location
        menuView.frame.size = CGSize(width: self.view.frame.width, height: self.computerVSComputerButton!.frame.origin.y - self.playerVSPlayerButton!.frame.origin.y + self.playerVSPlayerButton!.frame.height )
        menuView.frame.origin.y = self.view.frame.height / 2 - menuView.frame.size.height / 2
        
        //-- Add menu to the main view
        self.view.addSubview(menuView)
    }
    
    func addTargets() {
        self.playerVSPlayerButton?.addTarget(self, action: #selector(playerVSPlayerAction(sender:)), for: .touchUpInside)
        self.playerVSComputerButton?.addTarget(self, action: #selector(playerVSComputerAction(sender:)), for: .touchUpInside)
        self.computerVSComputerButton?.addTarget(self, action: #selector(computerVSComputerAction(sender:)), for: .touchUpInside)
    }
    
    func loadWeapons() {
        
        //-- Init weapons array
        self.weapons = []
        
        //-- Create some weapons. We can create all weapons we want
        let rock = Weapon(name: "rock")
        rock.image = UIImage(named: "rock")
        
        let paper = Weapon(name: "paper")
        paper.image = UIImage(named: "paper")
        
        let scissors = Weapon(name: "scissors")
        scissors.image = UIImage(named: "scissors")
        
        let lizard = Weapon(name: "lizard")
        lizard.image = UIImage(named: "lizard")
        
        let spock = Weapon(name: "spock")
        spock.image = UIImage(named: "spock")
        
        //-- For each weapons we define assets
        rock.moreStrongerThan = [scissors, lizard]
        paper.moreStrongerThan = [rock, spock]
        scissors.moreStrongerThan = [paper, lizard]
        lizard.moreStrongerThan = [spock, paper]
        spock.moreStrongerThan = [rock, scissors]
        
        //-- We insert weapons in array
        self.weapons?.append(rock)
        self.weapons?.append(paper)
        self.weapons?.append(scissors)
        self.weapons?.append(lizard)
        self.weapons?.append(spock)
    }
    
    func resetJanken() {
        self.newGame = nil
        self.newGame = Janken()
        self.newGame?.weapons = self.weapons
    }
    
    func playerVSPlayerAction(sender: UIButton) {
        
        //-- Reset Janken to nil each time we start/restart a game
        self.resetJanken()
        
        //-- Create two players
        let player1 = JankenPlayer(name: "Player 1")
        let player2 = JankenPlayer(name: "Player 2")
        
        //-- Insert players into the game
        self.newGame?.players = [player1, player2]
        
        //-- Display "playerView" to players
        self.playerView = PlayerView(frame: self.view.frame, newGame: newGame!, player: player2)
        self.view.addSubview(self.playerView!)
        self.playerView = PlayerView(frame: self.view.frame, newGame: newGame!, player: player1)
        self.view.addSubview(self.playerView!)
        
        //-- We delegate referee result to this controller
        self.newGame?.referee.delegate = self
    }
    
    func playerVSComputerAction(sender: UIButton) {
        
        //-- Reset Janken to nil each time we start/restart a game
        self.resetJanken()

        //-- Create a computer and a player
        let computer = JankenPlayer(name: "Computer")
        let you = JankenPlayer(name: "You")
        
        //-- Insert computer and player into the game
        self.newGame?.players = [computer, you]
        
        //-- We choose a random weapon for the computer
        computer.weaponChoose = getRandomWeapon()
        
        //-- We need to display a view for the human
        self.playerView = PlayerView(frame: self.view.frame, newGame: newGame!, player: you)
        self.view.addSubview(self.playerView!)
        
        //-- We delegate referee result to this controller
        self.newGame?.referee.delegate = self
    }
    
    
    func computerVSComputerAction(sender: UIButton) {
        
        //-- Reset Janken to nil each time we start/restart a game
        self.resetJanken()
        
        //-- Create two computers
        let computer1 = JankenPlayer(name: "Computer 1")
        let computer2 = JankenPlayer(name: "Computer 2")
        
        //-- Insert computers into the game
        self.newGame?.players = [computer1, computer2]
        
        //-- We choose random weapons for computers
        computer1.weaponChoose = getRandomWeapon()
        computer2.weaponChoose = getRandomWeapon()
        
        //-- We delegate referee result to this controller
        self.newGame!.referee.delegate = self
        
        //-- No need to display views. We display the result immediatly
        let players = self.newGame?.players
        self.newGame!.referee.defineWinners(players: players!)
    }
    
    func getRandomWeapon() -> Weapon? {
        guard let weapons = self.weapons else {
            return nil
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(weapons.count)))
        let randomWeapon = weapons[randomNumber]
        return randomWeapon
    }
}

extension JankenViewController: RefereeProtocolDelegate {
    
    func referre(didReceiveResult players: Array<JankenPlayer>, winners: Array<JankenPlayer>?) {
        let resultView = ResultView(frame: self.view.frame, players: players, winners: winners)
        self.view.addSubview(resultView)
    }
}

