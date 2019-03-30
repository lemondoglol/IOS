//
//  CircleView.swift
//  circles
//
//  Created by Admin on 3/29/19.
//  Copyright © 2019 lemondog. All rights reserved.
//

import UIKit

// drawing view here
class CircleView: UIView {

    var document: Document?
    
    override func draw(_ rect: CGRect) {
        if let doc = document, let container = doc.container {
            let path = UIBezierPath()
            for circle in container.circles {
                path.append(UIBezierPath (
                    arcCenter: circle.center,
                    radius: circle.radius,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2,
                    clockwise: true
                ))
            }
            UIColor.blue.setStroke()
            path.lineWidth = 3
            path.stroke()
        }
    }
    

}
