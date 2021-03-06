//
//  SimulatorViewController.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/15/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import UIKit

class SimulateSingleRoundViewController: UIViewController {
    @IBOutlet var communityCardImageViews: [UIImageView]!
    
    @IBOutlet var playerCardImageViews: [UIImageView]!
    
    @IBOutlet weak var handLabel: UILabel!
    
    var deck: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0..<52 {
            let card = Card(index: i)
            deck.append(card)
        }
    }
    
    @IBAction func mainButtonWasPressed(_ sender: UIButton) {
        
        Card.shuffle(cards: &deck, firstN: 7)
        
        for cardView in playerCardImageViews {
            guard let index = playerCardImageViews.index(of: cardView) else {
                fatalError("Could not get index of image view")
            }
            
            let card = deck[index]
            
            let image = card.getImage()
            
            cardView.image = image
        }
        
        for cardView in communityCardImageViews {
            guard let index = communityCardImageViews.index(of: cardView) else {
                fatalError("Could not get index of image view")
            }
            
            let card = deck[index + 2]
            
            let image = card.getImage()
            
            cardView.image = image
        }
        
        var handCards = [Card]()
        for i in 0..<7 {
            handCards.append(deck[i])
        }
        
        let hand = Hand(cards: handCards)
        
        handLabel.text = hand.string
    }
}

