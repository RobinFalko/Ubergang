//
//  ViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Foundation
import Ubergang

class BezierPathViewController: ExampleViewController {
    
    var targetView: UIImageView!
    
    var tween: BezierPathTween!
    
    var random: CGFloat {
        return CGFloat(Double(arc4random_uniform(255)) / 255.0)
    }
    
    override func viewDidLoad() {
        targetView = UIImageView(image: UIImage(named: "SliderThumb"))
        
        setupTween()
        
        view.addSubview(targetView)
        
        addTweenControls(tween)
    }
    
    deinit {
        print("deinit controller")
    }
    
    func setupTween() {
        
        let path = trianglePathInRect(CGRectMake(30, 100, 290, 450))
        
        tween = UTweenBuilder
            .to( path,
                 current: { path },
                 update: { [unowned self] (value:CGPoint, progress: Double) in
                    self.targetView.center = value
                    self.tweenControls.progress(progress)
                },
                 duration: 5,
                 id: "bezierTween")
        tween.ease(Linear.ease)
        tween.memoryReference(.Weak)
        tween.complete { [unowned self] in
            self.tweenControls.stop()
        }
    }
    
    func trianglePathInRect(rect:CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        var offset: CGFloat = 20
        
        let startPoint = CGPoint(x: rect.origin.x, y: rect.origin.y)
        self.targetView.center = startPoint
        path.moveToPoint(startPoint)
        path.addLineToPoint(CGPoint(x: CGFloat(arc4random_uniform(UInt32(rect.width))), y: rect.origin.y + offset))
        offset += 20
        path.addLineToPoint(CGPoint(x: CGFloat(arc4random_uniform(UInt32(rect.width))), y: rect.origin.y + offset))
        offset += 20
        
        for _ in 0...7 {
            let p1 = CGPoint(x: CGFloat(arc4random_uniform(UInt32(rect.width))), y: rect.origin.y + offset)
            offset += 20
            let p2 = CGPoint(x: CGFloat(arc4random_uniform(UInt32(rect.width))), y: rect.origin.y + offset)
            offset += 20
            let p3 = CGPoint(x: CGFloat(arc4random_uniform(UInt32(rect.width))), y: rect.origin.y + offset)
            offset += 20
            path.addCurveToPoint(p3, controlPoint1: p1, controlPoint2: p2)
        }
        
        
        let shape = CAShapeLayer()
        shape.path = path.CGPath
        shape.strokeColor = UIColor.redColor().CGColor
        shape.fillColor = UIColor.clearColor().CGColor
        view.layer.addSublayer(shape)
        
        return path
    }
}

