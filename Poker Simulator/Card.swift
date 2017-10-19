//
//  Card.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/15/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import Foundation
import UIKit

/// Ace has rank 14, 2 has rank 2
struct Card {
    let suit: Suit
    let rank: Int
    
    init(suit: Suit, value: Int) {
        self.suit = suit
        self.rank = value
    }
    
    init(index: Int) {
        
        let suitIndex = index % 4
        guard let suit = Suit(rawValue: suitIndex) else {
            fatalError("Could not get suit")
        }
        
        let value = index / 4 + 2
        
        self.suit = suit
        self.rank = value
    }
    
    func getImage() -> UIImage {
        let index = getIndex() as NSNumber
        let indexString = index.stringValue
        guard let image = UIImage(named: "\(indexString)_card") else {
            fatalError("Could not get image")
        }
        return image
    }
    
    func getIndex() -> Int {
        return (rank - 2) * 4 + suit.rawValue
    }
    
    static func getNewDeck(shuffled: Bool = false) -> [Card] {
        var deck = [Card]()
        for i in 0..<52 {
            let card = Card(index: i)
            deck.append(card)
        }
        
        if shuffled {
            Card.shuffle(cards: &deck)
        }
        
        return deck
    }
    
    
    /// Shuffles the first N cards of the deck
    ///
    /// - Parameters:
    ///   - cards:
    ///   - firstN:
    static func shuffle(cards: inout [Card], firstN: Int = 52) {
        // TODO: Improve the speed of this function
        assert(firstN > 0)
        assert(firstN <= 52)
        
        var newCards = [Card]()
        var cardsIndexSet = Set<Int>()
        for card in cards {
            cardsIndexSet.insert(card.getIndex())
        }
        var usedCardsIndexSet = Set<Int>()
        
        for _ in 0..<cards.count {
            var randomCardIndex = Int(arc4random_uniform(52))
            
            while usedCardsIndexSet.contains(randomCardIndex) || !cardsIndexSet.contains(randomCardIndex) {
                randomCardIndex = Int(arc4random_uniform(52))
            }
            
            let card = Card(index: randomCardIndex)
            newCards.append(card)
            usedCardsIndexSet.insert(randomCardIndex)
        }
        
        cards.removeAll()
        for card in newCards {
            cards.append(card)
        }
    }
}
