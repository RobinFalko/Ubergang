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

class DynamicViewController: ExampleViewController {
    let degToRad = CGFloat(M_PI / 180.0)
    
    var particles = [UIImageView]()
    
    var timeline: UTimeline!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        
        //creating that many bezier tweens will take some time
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            self.activityIndicator.startAnimating()
            self.loadingLabel.hidden = false
            
            self.setupTween()
            
            dispatch_async(dispatch_get_main_queue()) {
                for particle in self.particles {
                    self.view.addSubview(particle)
                }
                
                self.addTweenControls(self.timeline)
                
                self.activityIndicator.stopAnimating()
                self.loadingLabel.hidden = true
            }
        }
    }
    
    deinit {
        print("deinit \(self.dynamicType)")
    }
    
    func setupTween() {let rectWidth = CGFloat(200)
        let centerX = (UIScreen.mainScreen().bounds.width - rectWidth) * 0.5
        let path = rectInRect(CGRectMake(centerX, 200, rectWidth, rectWidth))
//        let path = circleInRect(CGRectMake(centerX, 200, rectWidth, rectWidth)) //shape example
//        let path = heartInRect(CGRectMake(centerX, 200, rectWidth, rectWidth)) //shape example
        drawPath(path)
        
        timeline = UTimeline(id: "timeline")
            .memoryReference(.Weak)
            .updateTotal { [unowned self] progressTotal in
                self.tweenControls.progress(progressTotal)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
        
        let totalDuration = 20.0
        
        var previousView: UIView?
        let itemCount = 200
        for i in 0..<itemCount {
            //a placeholder. Its position will be used as start or end value
            let placeholder = UIView()
            
            //compute the offset of all views on the path
            var offsetInterval = Double(i) / (Double(2))
            offsetInterval -= Double(Int(offsetInterval))
            let offset = Double(Int(i / 2)) / Double(itemCount) + offsetInterval
            
            //create the bezier tween
            let bezierTween = UTweenBuilder
                .along( path,
                    update: { (value:CGPoint, progress: Double) in
                        placeholder.center = value
                    },
                    duration: totalDuration,
                    id: "bezierTween \(i)")
                .memoryReference(.Weak)
                .offset(offset)

            //add it to the timeline
            timeline.insert(bezierTween, at: 0)
            
            //create the inner tween as a timeline if a connected (previous) view exists
            if let pView = previousView {
                let innerTimeline = UTimeline(id: "innerTimeline \(i)")
                
                //create the dot
                let targetView0 = createImageView(name: "Dot", color: UIColor.redColor())
                particles.append(targetView0)
                
                //an estimated offset
                let offset = Double(timeline.count - i - 1) * 0.03
                let duration = totalDuration
                
                //the first tween of the inner timline
                let tween0 = UTweenBuilder
                    .to({
                            placeholder.center
                        },
                        from: {
                            pView.center
                        },
                        update: { (value:CGPoint, progress: Double) in
                            targetView0.center = value
                        },
                         duration: duration,
                        id: "pointTween0 \(i)")
                    .ease(Cubic.easeOut)
                    .options(.Yoyo, .Repeat(10))
                
                innerTimeline.insert(tween0, at: offset)
                
                //create another dot
                let targetView1 = createImageView(name: "Dot", color: UIColor.purpleColor())
                particles.append(targetView1)
                
                //the second tween of the inner timline
                let tween1 = UTweenBuilder
                    .to({
                            pView.center
                        },
                        from: {
                            placeholder.center
                        },
                        update: { (value:CGPoint, progress: Double) in
                            targetView1.center = value
                        },
                        duration: duration,
                        id: "pointTween1 \(i)")
                    .ease(Cubic.easeOut)
                    .options(.Yoyo, .Repeat(10))
                
                innerTimeline.insert(tween1, at: offset)
                
                //add it to the main timeline
                timeline.insert(innerTimeline, at: 0)
                
                //reset the previous view
                previousView = nil
                
            } else {
                previousView = placeholder
            }
        }
    }
    
    func createImageView(name name: String, color: UIColor) -> UIImageView {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        view.image = UIImage(named: name)!.imageWithRenderingMode(.AlwaysTemplate)
        view.tintColor = color
        
        return view
    }
    
    func drawPath(path: UIBezierPath) {
        let shape = CAShapeLayer()
        shape.path = path.CGPath
        shape.strokeColor = UIColor.blackColor().CGColor
        shape.lineWidth = 0
        shape.fillColor = UIColor.clearColor().CGColor
        view.layer.addSublayer(shape)
    }
    
    //rect shape
    func rectInRect(rect:CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let startPoint = CGPoint(x: rect.minX, y: rect.minY)
        path.moveToPoint(startPoint)
        path.addLineToPoint(CGPoint(x: rect.maxX, y: rect.minY))
        path.addLineToPoint(CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLineToPoint(CGPoint(x: rect.minX, y: rect.maxY))
        path.closePath()
        
        return path
    }
    
    //heart shape
    func heartInRect(rect:CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let center = rect.minX + rect.width * 0.5
        let bottom = rect.maxY
        
        let startPoint = CGPoint(x: center, y: bottom)
        path.moveToPoint(startPoint)
        
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
    
    //circle shape
    func circleInRect(rect:CGRect) -> UIBezierPath {
        let radius = rect.width * 0.5
        let path = UIBezierPath(arcCenter: CGPointMake(rect.minX + radius, rect.minY + radius),
                                radius: radius,
                                startAngle: 0 * degToRad,
                                endAngle: 360 * degToRad,
                                clockwise: true)
        
        return path
    }
}

