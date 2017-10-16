//
//  Card.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/15/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import Foundation
import UIKit

/// Ace has value 14, 2 has value 2
struct Card {
    let suit: Suit
    let value: Int
    
    init(suit: Suit, value: Int) {
        self.suit = suit
        self.value = value
    }
    
    init(index: Int) {
        
        let suitIndex = index % 4
        guard let suit = Suit(rawValue: suitIndex) else {
            fatalError("Could not get suit")
        }
        
        let value = index / 4 + 2
        
        self.suit = suit
        self.value = value
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
        return (value - 2) * 4 + suit.rawValue
    }
}
