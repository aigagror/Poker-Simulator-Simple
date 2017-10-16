//
//  SimulatorViewController.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/15/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import UIKit

class SimulatorViewController: UIViewController {
    @IBOutlet var communityCardImageViews: [UIImageView]!
    
    @IBOutlet var playerCardImageViews: [UIImageView]!
    
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
        
        shuffleDeck(firstN: 7)
        
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
        
        
    }
    
    private func shuffleDeck(firstN: Int = 52) {
        assert(firstN > 0)
        assert(firstN <= 52)
        
        for i in 0..<firstN {
            let randIndex = Int(arc4random_uniform(52))
            let tempCard = deck[i]
            deck[i] = deck[randIndex]
            deck[randIndex] = tempCard
        }
    }
}

