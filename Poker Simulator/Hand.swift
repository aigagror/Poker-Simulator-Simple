//
//  Hand.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/15/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import Foundation

enum HandType: Int {
    case highCard = 0, onePair, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush
}

struct Hand: Hashable {
    
    var hashValue: Int {
        return ranks.reduce(handType.rawValue) { (result, rank) -> Int in
            (result << 2) + rank
        }
    }
    
    static func ==(lhs: Hand, rhs: Hand) -> Bool {
        if lhs.handType == rhs.handType && lhs.ranks.count == rhs.ranks.count {
            let n = lhs.ranks.count
            
            for i in 0..<n {
                let v1 = lhs.ranks[i]
                let v2 = rhs.ranks[i]
                
                if v1 != v2 {
                    return false
                }
            }
            
            return true
        } else {
            return false
        }
    }
    
    var handType: HandType
    
    var ranks: [Int]
    
    init(cards: [Card]) {
        (handType, ranks) = Hand.getHandType(cards: cards)
    }
    
    init(index: Int = 0) {
        guard let handType = HandType(rawValue: index) else {
            fatalError("Could not get handtype raw value")
        }
        self.handType = handType
        
        ranks = []
    }
    
    private init(handType: HandType) {
        self.handType = handType
        self.ranks = []
    }
    
    static func getString(handType: HandType) -> String {
        let hand = Hand(handType: handType)
        return hand.string
    }
    
    var string: String {
        get {
            switch handType {
            case .highCard:
                return "High Card"
            case .onePair:
                return "One Pair"
            case .twoPair:
                return "Two Pair"
            case .threeOfAKind:
                return "Three of a Kind"
            case .straight:
                return "Straight"
            case .flush:
                return "Flush"
            case .fullHouse:
                return "Full House"
            case .fourOfAKind:
                return "Four of a Kind"
            case .straightFlush:
                guard let highestValue = ranks.first else {
                    return "Straight Flush"
                }
                
                if highestValue == 14 {
                    return "Royal Flush!"
                } else {
                    return "Straight Flush"
                }
            }
        }
    }
    
    
    static private func getHandType(cards: [Card]) -> (HandType, [Int]) {
        assert(cards.count > 0)
        
        // TODO: This function is faulty. Fix with test cases
        
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
                    suitCounter[suit] = count
                } else {
                    suitCounter[suit] = 1
                }
            }
            
            for suitCount in suitCounter where suitCount.value >= 5 {
                flushSuit = suitCount.key
                break
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
            let flushCards = cards.filter({ (card) -> Bool in
                card.suit == flushSuit
            })
            
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
            let singleCards = cards.filter({ (card) -> Bool in
                card.rank != pair
            })
            
            let sortedSingleCards = singleCards.sorted(by: { (a, b) -> Bool in
                a.rank > b.rank
            })
            
            let ranks = sortedSingleCards.map({ (card) -> Int in
                return card.rank
            })
            
            return (.straightFlush, ranks)
        }
        
        let ranks = sortedCards.map { (card) -> Int in
            return card.rank
        }
        
        return (.highCard, ranks)
    }
}
