//
//  TriangleView.swift
//  HPShowCase
//
//  Created by Mehdi Gilanpour on 9/2/17.
//  Copyright © 2017 Arash Farahani & Mehdi Gilanpour. All rights reserved.
//

import UIKit

class TriangleView : UIView {
    
    var color: UIColor!
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        
        self.color = color
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            context.beginPath()
            context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
            context.closePath()
            
            context.setFillColor(red: CGFloat(iRed), green: CGFloat(iGreen), blue: CGFloat(iBlue), alpha: CGFloat(iAlpha))
            context.fillPath()
        }
    }
}
