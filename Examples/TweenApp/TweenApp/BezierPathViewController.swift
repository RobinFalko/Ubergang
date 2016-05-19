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
        
        let rectWidth = CGFloat(130)
        let centerX = (UIScreen.mainScreen().bounds.width - rectWidth) * 0.5
        let path = heartInRect(CGRectMake(centerX, 100, rectWidth, 260))
        
        drawPath(path)
        
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
    
    func drawPath(path: UIBezierPath) {
        let shape = CAShapeLayer()
        shape.path = path.CGPath
        shape.strokeColor = UIColor.redColor().CGColor
        shape.fillColor = UIColor.clearColor().CGColor
        view.layer.addSublayer(shape)
    }
    
    func heartInRect(rect:CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let center = rect.minX + rect.width * 0.5
        let bottom = rect.maxY
        
        path.moveToPoint(CGPoint(x: center, y: bottom))
        
        var p1 = CGPoint(x: center, y: bottom - 60)
        var p2 = CGPoint(x: center - 160, y: bottom - 116)
        var p3 = CGPoint(x: center - 130, y: bottom - 200)
        path.addCurveToPoint(p3, controlPoint1: p1, controlPoint2: p2)
        
        p1 = CGPoint(x: center - 100, y: bottom - 280)
        p2 = CGPoint(x: center - 15, y: bottom - 255)
        p3 = CGPoint(x: center, y: bottom - 225)
        path.addCurveToPoint(p3, controlPoint1: p1, controlPoint2: p2)
        
        p1 = CGPoint(x: center + 15, y: bottom - 255)
        p2 = CGPoint(x: center + 100, y: bottom - 280)
        p3 = CGPoint(x: center + 130, y: bottom - 200)
        path.addCurveToPoint(p3, controlPoint1: p1, controlPoint2: p2)
            
        p1 = CGPoint(x: center + 160, y: bottom - 116)
        p2 = CGPoint(x: center, y: bottom - 60)
        p3 = CGPoint(x: center, y: bottom)
        path.addCurveToPoint(p3, controlPoint1: p1, controlPoint2: p2)
        
        return path
    }
    
//    func randomPath() -> UIBezierPath {
//        let path = UIBezierPath()
//        
//        let startPoint = CGPoint(x: 30, y: 100)
//        self.targetView.center = startPoint
//        path.moveToPoint(startPoint)
//        
//        for _ in 0...10 {
//            print("\(arc4random_uniform(2))")
//            if arc4random_uniform(2) == 1 {
//                path.addLineToPoint(getRndPointOnScreen())
//            } else {
//                let p1 = getRndPointOnScreen()
//                let p2 = getRndPointOnScreen()
//                let p3 = getRndPointOnScreen()
//                path.addCurveToPoint(p3, controlPoint1: p1, controlPoint2: p2)
//            }
//        }
//        
//        let shape = CAShapeLayer()
//        shape.path = path.CGPath
//        shape.strokeColor = UIColor.redColor().CGColor
//        shape.fillColor = UIColor.clearColor().CGColor
//        view.layer.addSublayer(shape)
//        
//        return path
//    }
    
    func getRndPointOnScreen() -> CGPoint {
        let width = UInt32(UIScreen.mainScreen().bounds.width - 200)
        let height = UInt32(UIScreen.mainScreen().bounds.height - 200)
        
        let rndWidth = CGFloat(arc4random_uniform(width))
        let rndHeight = CGFloat(arc4random_uniform(height))
        
        return CGPoint(x: rndWidth + 100, y: rndHeight + 100)
    }
}

