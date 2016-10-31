//
//  JankenTests.swift
//  JankenTests
//
//  Created by Rplay on 30/10/2016.
//  Copyright © 2016 rplay. All rights reserved.
//

import XCTest
@testable import Janken

class JankenTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        testResult()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func defineWinners(players: Array<JankenPlayer>) -> Array<JankenPlayer>? {
        
        var winners: Array<JankenPlayer> = []
        var losers: Array<JankenPlayer> = []
        var playersToCompare: Array<JankenPlayer> = players
        
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
        
        return winnersWithoutLosing
        
    }
    
    func testResult() {
        
        var weapons: Array<Weapon> = []
        
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
        
        rock.moreStrongerThan = [scissors, lizard]
        paper.moreStrongerThan = [rock, spock]
        scissors.moreStrongerThan = [paper, lizard]
        lizard.moreStrongerThan = [spock, paper]
        spock.moreStrongerThan = [rock, scissors]
        
        weapons.append(rock)
        weapons.append(paper)
        weapons.append(scissors)
        weapons.append(lizard)
        weapons.append(spock)
        
        let newGame = Janken()
        newGame.weapons = weapons
        
        let player1 = JankenPlayer(name: "Player 1")
        let player2 = JankenPlayer(name: "Player 2")
        let player3 = JankenPlayer(name: "Player 3")
        let player4 = JankenPlayer(name: "Player 4")
        
        newGame.players = [player1, player2, player3, player4]
        
        player1.weaponChoose = rock
        player2.weaponChoose = paper
        player3.weaponChoose = rock
        player4.weaponChoose = lizard
        
        let winners = self.defineWinners(players: newGame.players!)
        
        XCTAssertTrue(winners == nil, "Nobody win, paper envelope rock, lizard eats paper, rock cruches lizard")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
