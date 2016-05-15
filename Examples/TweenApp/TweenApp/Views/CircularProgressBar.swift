//
//  CircularProgressBar.swift
//  TweenApp
//
//  Created by RF on 09/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

class CircularProgressBar: UIView {
    let degToRad = CGFloat(M_PI / 180.0)
    
    var shapeLayer:CAShapeLayer!
    
    var _startAngle: CGFloat = -90.0
    var startAngle: CGFloat {
        get {
            return _startAngle
        }
        set {
            _startAngle = newValue - 90
            update()
        }
    }
    var _endAngle: CGFloat = -90.0
    var endAngle: CGFloat {
        get {
            return _endAngle
        }
        set {
            _endAngle = newValue - 90
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        shapeLayer = CAShapeLayer()
        
        update()
        
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 10.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func update() {
        shapeLayer.path = arcPath().CGPath
    }
    
    func arcPath() -> UIBezierPath {
        let radius = frame.size.width * 0.5
        let path = UIBezierPath(arcCenter: CGPointMake(radius, radius),
                                radius: radius,
                                startAngle: startAngle * degToRad,
                                endAngle: endAngle * degToRad,
                                clockwise: true)
        
        return path
    }
}
