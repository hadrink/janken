//
//  Referee.swift
//  Janken
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import Foundation

protocol RefereeProtocol {
    func defineWinners(players: Array<JankenPlayer>)
}

protocol RefereeProtocolDelegate {
    func referre(didReceiveResult players: Array<JankenPlayer>, winners: Array<JankenPlayer>?)
}

class Referee: RefereeProtocol {
    
    //-- Delegate var to send winners to an other class
    var delegate: RefereeProtocolDelegate?
    
    func defineWinners(players: Array<JankenPlayer>) {
        
        //-- Create a winners and losers array
        var winners: Array<JankenPlayer> = []
        var losers: Array<JankenPlayer> = []
        
        //-- Set players to an other to compare
        var playersToCompare: Array<JankenPlayer> = players
        
        //-- Compares if each player wins one against the other
        for i in 0..<players.count {
            for player in players {
                
                if player.name == playersToCompare[i].name {
                    print("compare the same player is useless")
                } else {
                    let weaponChooseByThePlayer = player.weaponChoose
                    let weaponChooseByThePlayerToCompare = playersToCompare[i].weaponChoose
                    
                    guard let moreStrongerThanList = weaponChooseByThePlayer?.moreStrongerThan else {
                        break
                    }
                    
                    let playerDefeatPlayerToCompare = moreStrongerThanList.contains(where: { $0.name == weaponChooseByThePlayerToCompare?.name })
                    
                    if playerDefeatPlayerToCompare {
                        winners.append(player)
                        losers.append(playersToCompare[i])
                    }
                }
            }
        }
        
        //-- A rock, paper, scissors winner is a player who wins without losing
        var winnersWithoutLosing: Array<JankenPlayer>?
        
        for player in players {
            let playerWon = winners.contains(where: {$0.name == player.name})
            let playerLoose = losers.contains(where: {$0.name == player.name})
            
            if playerWon && !playerLoose {
                
                if winnersWithoutLosing == nil {
                    winnersWithoutLosing = []
                }
                
                winnersWithoutLosing!.append(player)
            }
        }
        
        self.delegate?.referre(didReceiveResult: players, winners: winnersWithoutLosing)
    }
}

