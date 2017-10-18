//
//  RulerView.swift
//  Poker Simulator
//
//  Created by Edward Huang on 10/17/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import UIKit

class RulerView: UIView {
    
    var backGroundColor: UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var numberOfTicks: Int = 11 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lineWidth: CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    let standardTickHeightToFrameHeightRatio: CGFloat = 0.5

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        backGroundColor.setFill()
        
        UIBezierPath(rect: self.bounds).fill()
        
        UIColor.black.set()
        
        let height = self.bounds.height
        let width = self.bounds.width
        
        let pencil = UIBezierPath()
        
        pencil.lineWidth = lineWidth
        
        pencil.move(to: CGPoint(x: 0, y: height/2))
        
        pencil.addLine(to: CGPoint(x: width, y: height/2))
        
        pencil.stroke()
        
        for i in 0..<numberOfTicks {
            
        }
    }
}
