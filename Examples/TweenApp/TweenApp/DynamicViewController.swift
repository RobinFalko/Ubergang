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
        DispatchQueue.global(qos: .default).async {
            
            self.activityIndicator.startAnimating()
            self.loadingLabel.isHidden = false
            
            self.setupTween()
            
            DispatchQueue.main.async {
                for particle in self.particles {
                    self.view.addSubview(particle)
                }
                
                self.addTweenControls(self.timeline)
                
                self.activityIndicator.stopAnimating()
                self.loadingLabel.isHidden = true
            }
        }
    }
    
    deinit {
        print("deinit \(type(of: self))")
    }
    
    func setupTween() {let rectWidth = CGFloat(200)
        let centerX = (UIScreen.main.bounds.width - rectWidth) * 0.5
        let path = rectInRect(CGRect(x: centerX, y: 200, width: rectWidth, height: rectWidth))
//        let path = circleInRect(CGRectMake(centerX, 200, rectWidth, rectWidth)) //shape example
//        let path = heartInRect(CGRectMake(centerX, 200, rectWidth, rectWidth)) //shape example
        drawPath(path)
        
        timeline = UTimeline(id: "timeline")
            .memoryReference(.weak)
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
                .memoryReference(.weak)
                .offset(offset)

            //add it to the timeline
            timeline.insert(bezierTween, at: 0)
            
            //create the inner tween as a timeline if a connected (previous) view exists
            if let pView = previousView {
                let innerTimeline = UTimeline(id: "innerTimeline \(i)")
                
                //create the dot
                let targetView0 = createImageView(name: "Dot", color: UIColor.red)
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
                    .options(.yoyo, .repeat(10))
                
                innerTimeline.insert(tween0, at: offset)
                
                //create another dot
                let targetView1 = createImageView(name: "Dot", color: UIColor.purple)
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
                    .options(.yoyo, .repeat(10))
                
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
    
    func createImageView(name: String, color: UIColor) -> UIImageView {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        view.image = UIImage(named: name)!.withRenderingMode(.alwaysTemplate)
        view.tintColor = color
        
        return view
    }
    
    func drawPath(_ path: UIBezierPath) {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.lineWidth = 0
        shape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shape)
    }
    
    //rect shape
    func rectInRect(_ rect:CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let startPoint = CGPoint(x: rect.minX, y: rect.minY)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.close()
        
        return path
    }
    
    //heart shape
    func heartInRect(_ rect:CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let center = rect.minX + rect.width * 0.5
        let bottom = rect.maxY
        
        let startPoint = CGPoint(x: center, y: bottom)
        path.move(to: startPoint)
        
        var p1 = CGPoint(x: center, y: bottom - 60)
        var p2 = CGPoint(x: center - 160, y: bottom - 116)
        var p3 = CGPoint(x: center - 130, y: bottom - 200)
        path.addCurve(to: p3, controlPoint1: p1, controlPoint2: p2)
        
        p1 = CGPoint(x: center - 100, y: bottom - 280)
        p2 = CGPoint(x: center - 15, y: bottom - 255)
        p3 = CGPoint(x: center, y: bottom - 225)
        path.addCurve(to: p3, controlPoint1: p1, controlPoint2: p2)
        
        p1 = CGPoint(x: center + 15, y: bottom - 255)
        p2 = CGPoint(x: center + 100, y: bottom - 280)
        p3 = CGPoint(x: center + 130, y: bottom - 200)
        path.addCurve(to: p3, controlPoint1: p1, controlPoint2: p2)
        
        p1 = CGPoint(x: center + 160, y: bottom - 116)
        p2 = CGPoint(x: center, y: bottom - 60)
        p3 = CGPoint(x: center, y: bottom)
        path.addCurve(to: p3, controlPoint1: p1, controlPoint2: p2)
        
        return path
    }
    
    //circle shape
    func circleInRect(_ rect:CGRect) -> UIBezierPath {
        let radius = rect.width * 0.5
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                                radius: radius,
                                startAngle: 0 * degToRad,
                                endAngle: 360 * degToRad,
                                clockwise: true)
        
        return path
    }
}

