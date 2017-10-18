//
//  HorizontalGrapBarView.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/17/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import UIKit

class HorizontalGrapBarView: UIView {
    
    /// Color of the bar
    var color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// Value is any real number from 0 to 1
    var value: Float = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var scale: Float = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let bgColor: UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        bgColor.set()
        
        UIBezierPath(rect: self.bounds).fill()
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        let barRect = CGRect(origin: .zero, size: CGSize(width: width * CGFloat(value * scale), height: height))
        
        let barPath = UIBezierPath(rect: barRect)
        
        color.set()
        
        barPath.fill()
    }
 

}
