//
//  ScaleView.swift
//  Scale
//
//  Created by Andrew Belozerov on 25.10.16.
//  Copyright © 2016 Andrew Iron. All rights reserved.
//

import UIKit

@IBDesignable
class ScaleView: UIView {

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(14.0)
        context?.addArc(center: CGPoint(x: 375 / 2, y: 375 / 2), radius: 375 / 2 - 14, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        context?.strokePath()
        
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.addArc(center: CGPoint(x: 375 / 2, y: 375 / 2), radius: 375 / 4 - 14, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        context?.strokePath()
        
    }

}
