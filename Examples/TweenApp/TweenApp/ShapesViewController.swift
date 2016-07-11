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

class ShapesViewController: ExampleViewController {
    
    var targetView: UIImageView!
    
    var tween: BezierPathTween!
    
    override func viewDidLoad() {
        targetView = UIImageView(image: UIImage(named: "SliderThumb"))
        
        setupTween()
        
        view.addSubview(targetView)
        
//        addTweenControls(tween)
    }
    
    deinit {
        print("deinit \(self.dynamicType)")
    }
    
    let anim = CABasicAnimation()
    var circleShape: CAShapeLayer!
    func setupTween() {
        
        let circlePath = circlePathWithCenter(CGPoint(x: UIScreen.mainScreen().bounds.width * 0.5, y: 250), radius: 50)
        let squarePath = squarePathWithCenter(CGPoint(x: UIScreen.mainScreen().bounds.width * 0.5, y: 250), side: 50)
        circleShape = drawPath(circlePath)
        view.layer.addSublayer(circleShape)
        
        anim.keyPath = "path"
        anim.fromValue = circleShape.path
        anim.toValue = drawPath(squarePath).path
        anim.duration = 1.0
        anim.fillMode = kCAFillModeForwards
        anim.removedOnCompletion = false
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        circleShape.addAnimation(anim, forKey: "animatePath1")
        circleShape.speed = 0.0
        
        
//        tween = UTweenBuilder
//            .along( points,
//                 update: { [unowned self] (value:CGPoint) in
//                    self.targetView.center = value
//                },
//                 duration: 5,
//                 id: "bezierTween",
//                 closed: true)
//            .ease(Linear.ease)
//            .options(.Repeat(1))
//            .memoryReference(.Weak)
//            .updateTotal { [unowned self] value in
//                self.tweenControls.progress(value)
//            }
//            .complete { [unowned self] in
//                self.tweenControls.stop()
//            }
    }
    
    @IBAction func onValueChanged(sender: UISlider) {
        circleShape.timeOffset = Double(sender.value)
        print("circleShape.timeOffset: \(circleShape.timeOffset)")
    }
    
    func drawPath(path: UIBezierPath) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path.CGPath
        shape.strokeColor = UIColor.redColor().CGColor
        shape.fillColor = UIColor.clearColor().CGColor
        
        return shape
    }
    
    func circlePathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath()
        circlePath.addArcWithCenter(center, radius: radius, startAngle: -CGFloat(M_PI), endAngle: -CGFloat(M_PI/2), clockwise: true)
        circlePath.addArcWithCenter(center, radius: radius, startAngle: -CGFloat(M_PI/2), endAngle: 0, clockwise: true)
        circlePath.addArcWithCenter(center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI/2), clockwise: true)
        circlePath.addArcWithCenter(center, radius: radius, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(M_PI), clockwise: true)
        circlePath.closePath()
        return circlePath
    }
    
    func squarePathWithCenter(center: CGPoint, side: CGFloat) -> UIBezierPath {
        let squarePath = UIBezierPath()
        let startX = center.x - side / 2
        let startY = center.y - side / 2
        squarePath.moveToPoint(CGPoint(x: startX, y: startY))
        squarePath.addLineToPoint(squarePath.currentPoint)
        squarePath.addLineToPoint(CGPoint(x: startX + side, y: startY))
        squarePath.addLineToPoint(squarePath.currentPoint)
        squarePath.addLineToPoint(CGPoint(x: startX + side, y: startY + side))
        squarePath.addLineToPoint(squarePath.currentPoint)
        squarePath.addLineToPoint(CGPoint(x: startX, y: startY + side))
        squarePath.addLineToPoint(squarePath.currentPoint)
        squarePath.closePath()
        return squarePath
    }
}

