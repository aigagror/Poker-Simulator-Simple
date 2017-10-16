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
}
