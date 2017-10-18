//
//  BarGraphTableViewCell.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/17/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import UIKit

class BarGraphTableViewCell: UITableViewCell {
    
    var barColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            barView.color = barColor
        }
    }
    
    var barValue: Float = 0.5 {
        didSet {
            barView.value = barValue
        }
    }
    
    var handType: HandType = .highCard {
        didSet {
            label.text = Hand.getString(handType: handType)
        }
    }

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet private weak var barView: HorizontalGrapBarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
