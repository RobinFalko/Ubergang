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

class CurveThroughViewController: ExampleViewController {
    
    var targetView: UIImageView!
    
    var tween: BezierPathTween!
    
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
        let points = raceTrack(CGRectMake(centerX, 100, rectWidth, 260))
        
        let numbers = points.map { NSValue(CGPoint: $0) }
        let path = UIBezierPath.interpolateCGPointsWithCatmullRom(numbers, closed: true, alpha: 1.0)
        
        drawPath(path)
        
        tween = UTweenBuilder
            .along( points,
                 update: { [unowned self] (value:CGPoint, progress: Double) in
                    self.targetView.center = value
                },
                 duration: 5,
                 id: "bezierTween",
                 closed: true)
            .ease(Linear.ease)
            .options(.Repeat(1))
            .memoryReference(.Weak)
            .updateTotal { [unowned self] value in
                self.tweenControls.progress(value)
            }
            .complete { [unowned self] in
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
    
    func raceTrack(rect:CGRect) -> [CGPoint] {
        
        var points = [CGPoint]()
        points.append(CGPoint(x: rect.minX, y: rect.minY))
        points.append(CGPoint(x: rect.midX, y: rect.midY))
        points.append(CGPoint(x: rect.minX, y: rect.maxY))
        points.append(CGPoint(x: rect.maxX, y: rect.maxY))
        points.append(CGPoint(x: rect.maxX, y: rect.minY))
        
        return points
    }
}

