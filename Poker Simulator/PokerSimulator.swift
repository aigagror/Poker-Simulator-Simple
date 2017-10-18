//
//  PokerSimulator.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/17/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import Foundation
import UIKit

class PokerSimulator {
    static var totalTrials = 0
    static var handCounter = [HandType:Int]()
    
    private static var simulating = false
    
    private static let simulatorQueue = DispatchQueue(label: "simulatorQueue")
    
    static func startSimulating(update tableView: UITableView? = nil) -> Void {
        let updateFrequency = 1
        
        if !simulating {
            simulating = true
            simulatorQueue.async {
                var deck = Card.getNewDeck()
                
                while simulating {
                    usleep(100000)
                    
                    Card.shuffle(cards: &deck, firstN: 7)
                    
                    var first7 = [Card]()
                    
                    for i in 0..<7 {
                        first7.append(deck[i])
                    }
                    
                    let hand = Hand(cards: first7)
                    let handType = hand.handType
                    
                    if let count = handCounter[handType] {
                        handCounter[handType] = count + 1
                    } else {
                        handCounter[handType] = 1
                    }
                    
                    totalTrials += 1
                    
                    if let tableView = tableView, totalTrials % updateFrequency == 0 {
                        // update table every now and then
                        DispatchQueue.main.async {
                            for i in 0..<9 {
                                let indexPath = IndexPath(row: i, section: 0)
                                
                                guard let cell = tableView.cellForRow(at: indexPath) as? BarGraphTableViewCell else {
                                    fatalError("Could not get bar graph cell")
                                }
                                
                                let handType = cell.handType
                                
                                if let count = handCounter[handType] {
                                    cell.barValue = Float(count) / Float(totalTrials)
                                } else {
                                    cell.barValue = 0.0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func stopSimulating() {
        simulating = false
    }
    
    
    static func reset(update tableView: UITableView? = nil) {
        stopSimulating()
        
        PokerSimulator.handCounter = [:]
        PokerSimulator.totalTrials = 0
        
        if let tableView = tableView {
            for i in 0..<9 {
                let indexPath = IndexPath(row: i, section: 0)
                
                guard let cell = tableView.cellForRow(at: indexPath) as? BarGraphTableViewCell else {
                    fatalError("Could not get bar graph cell")
                }
                
                cell.barValue = 0.0
            }
        }
    }
}
