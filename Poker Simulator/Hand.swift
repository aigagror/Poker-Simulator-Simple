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
        
        
        
    }
    
    
    private func getNumberOfValues(for handType: HandType) -> Int {
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
