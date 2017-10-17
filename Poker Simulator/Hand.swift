//
//  Hand.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/15/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import Foundation

struct Hand {
    enum HandType: Int {
        case highCard = 0, onePair, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush
    }
    
    var handType: HandType
    
    var values: [Int]
    
    
    init(cards: [Card]) {
        
        self.handType = Hand.getHandType(cards: cards).0
        
        let n = Hand.getNumberOfValues(for: self.handType)
        
        values = Array(repeating: 0, count: n)
        
        let sortedCards = cards.sorted { (a, b) -> Bool in
            a.rank > b.rank
        }
        
        for i in 0..<n {
            values[i] = sortedCards[i].rank
        }
    }
    
    static private func getHandType(cards: [Card]) -> (HandType, [Int]) {
        assert(cards.count > 0)
        
        var straight: Int?
        var flushSuit: Suit?
        
        let sortedCards = cards.sorted { (a, b) -> Bool in
            a.rank > b.rank
        }
        
        if cards.count >= 5 {
            // Check if there's a straight
            for i in 0..<(sortedCards.count - 5 + 1) {
                var currValue = sortedCards[i].rank
                
                var foundStraight = true
                for j in (i+1)...(i+4) {
                    let nextValue = sortedCards[j].rank
                    
                    if nextValue != currValue - 1 {
                        foundStraight = false
                        break
                    }
                    currValue = nextValue
                }
                if foundStraight {
                    straight = i
                    break
                }
            }
            
            // Check if there's a flush
            var suitCounter = [Suit:Int]()
            for card in cards {
                let suit = card.suit
                if let count = suitCounter[suit] {
                    suitCounter[suit] = count + 1
                } else {
                    suitCounter[suit] = 1
                }
            }
            
            for suitCount in suitCounter where suitCount.value >= 5 {
                flushSuit = suitCount.key
            }
        }
        
        // Check for straight flush
        if let straight = straight, flushSuit != nil {
            return (.straightFlush, [straight])
        }
        
        // Do a rank count
        var rankCounter = [Int:Int]()
        for card in cards {
            let rank = card.rank
            if let count = rankCounter[rank] {
                rankCounter[rank] = count + 1
            } else {
                rankCounter[rank] = 1
            }
        }
        
        // Multiple hand analysis
        var highestThreeOfAKind: Int?
        var highestPair: Int?
        guard let highCard = sortedCards.first else {
            fatalError("Cards were empty")
        }
        
        for rankCount in rankCounter {
            let rank = rankCount.key
            let count = rankCount.value
            
            switch count {
            case 4:
                // Check for four of a kind
                return (.fourOfAKind, [rank])
            case 3:
                if let currHighestTOAK = highestThreeOfAKind {
                    highestThreeOfAKind = max(currHighestTOAK, rank)
                } else {
                    highestThreeOfAKind = rank
                }
            case 2:
                if let currHighestPair = highestPair {
                    highestPair = max(currHighestPair, rank)
                } else {
                    highestPair = rank
                }
            default: break
            }
        }
        
        // Check for full house
        if let toak = highestThreeOfAKind, highestPair != nil {
            return (.fullHouse, [toak])
        }
        
        // Check for flush
        if let flushSuit = flushSuit {
            var flushCards = [Card]()
            for card in cards where card.suit == flushSuit {
                flushCards.append(card)
            }
            
            let sortedFlushCards = flushCards.sorted(by: { (a, b) -> Bool in
                a.rank > b.rank
            })
            
            var ranks = [Int]()
            for card in sortedFlushCards {
                ranks.append(card.rank)
            }
            
            return (.flush, ranks)
        }
        
        // Check for straight
        if let straight = straight {
            return (HandType.straight, [straight])
        }
        
        // Check for three of a kind
        if let toak = highestThreeOfAKind {
            return (.threeOfAKind, [toak])
        }
        
        // Check for two pair
        if cards.count - rankCounter.count >= 2 {
            guard let highestPair = highestPair else {
                fatalError("Could not get highest pair")
            }
            
            // Get second highest pair
            var secondHighestPair = 0
            for rankCount in rankCounter where rankCount.key != highestPair && rankCount.value >= 2 {
                secondHighestPair = max(secondHighestPair, rankCount.key)
            }
            
            // Get the highest other
            var highestOther = 0
            for card in cards where card.rank != highestPair && card.rank != secondHighestPair {
                highestOther = max(highestOther, card.rank)
            }
            
            guard secondHighestPair > 0 && highestOther > 0 else {
                fatalError("Failed to get valid second highest pair or highest other")
            }
            
            return (.twoPair, [highestPair, secondHighestPair, highestOther])
        }
        
        // Check for pair
        if let pair = highestPair {
            var singleCards = [Card]()
            for card in cards where card.rank != pair {
                singleCards.append(card)
            }
            
            let sortedSingleCards = singleCards.sorted(by: { (a, b) -> Bool in
                a.rank > b.rank
            })
            
            let ranks = sortedSingleCards.map({ (card) -> Int in
                return card.rank
            })
            
            return (.onePair, ranks)
        }
        
        let ranks = sortedCards.map { (card) -> Int in
            return card.rank
        }
        
        return (.highCard, ranks)
    }
    
    
    
    
    static private func getNumberOfValues(for handType: HandType) -> Int {
        switch handType {
        case .highCard, .flush:
            return 5
        case .onePair:
            return 4
        case .twoPair:
            return 3
        default:
            return 1
        }
    }
}
