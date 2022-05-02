//
//  HeartButton.swift
//  Homework
//
//  Created by Александр on 13.04.2021.
//

import UIKit

@IBDesignable class HeartButton: UIButton {
    
    @IBInspectable var filled: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var strokeWidth: CGFloat = 2.0
    @IBInspectable var strokeColor: UIColor?

    override func draw(_ rect: CGRect) {

        let heartPath = UIBezierPath()
    
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
    
        heartPath.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: CGFloat(arcRadius), startAngle: 135 * .pi / 180, endAngle: 315 * .pi / 180, clockwise: true)
        heartPath.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
        heartPath.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: CGFloat(arcRadius), startAngle: 225 * .pi / 180, endAngle: 45 * .pi / 180, clockwise: true)
        heartPath.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
        heartPath.close()
        heartPath.lineWidth = self.strokeWidth
    
        if self.strokeColor != nil {
            self.strokeColor!.setStroke()
        } else {
            self.tintColor.setStroke()
        }

        heartPath.stroke()

        if self.filled {
            self.tintColor.setFill()
            heartPath.fill()
        }
    }
    
}
