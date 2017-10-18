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
    var color: UIColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) {
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
    
    var numberOfTicks: Int = 11 {
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
        
        let pencil = UIBezierPath()
        pencil.lineWidth = 1.0
        let tickColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tickColor.set()
        for i in 0..<numberOfTicks {
            let xPos = CGFloat(i) / CGFloat(numberOfTicks - 1) * width
            pencil.move(to: CGPoint(x: xPos, y: 0))
            pencil.addLine(to: CGPoint(x: xPos, y: height))
            pencil.stroke()
        }
        
        
        let barRect = CGRect(origin: .zero, size: CGSize(width: width * CGFloat(value * scale), height: height))
        
        let barPath = UIBezierPath(rect: barRect)
        
        color.withAlphaComponent(0.7).set()
        
        barPath.fill()
    }
 

}
