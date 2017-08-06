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
    
    override func loadView() {
        super.loadView()
        
        targetView = UIImageView(image: UIImage(named: "PlayIcon")?.withRenderingMode(.alwaysTemplate))
        targetView.tintColor = UIColor(red: 73 / 255, green: 205 / 255, blue: 6 / 255, alpha: 0.75)
        view.addSubview(targetView)
    }
    
    override func setupTween() -> UTweenBase {
        let rectWidth = CGFloat(130)
        let centerX = (UIScreen.main.bounds.width - rectWidth) * 0.5
        let points = raceTrack(CGRect(x: centerX, y: 100, width: rectWidth, height: 260))
        
        let numbers = points.map { NSValue(cgPoint: $0) }
        let path = UIBezierPath.interpolateCGPoints(withCatmullRom: numbers, closed: true, alpha: 1.0)
        
        drawPath(path!)
        
        return BezierPathTween(id: "bezierTween")
            .along(points, closed: true)
            .update { [unowned self] (value:CGPoint, progress: Double, orientation: CGPoint) in
                self.targetView.center = value
                
                let angle = atan2(orientation.y, orientation.x)
                let transform = CGAffineTransform.identity.rotated(by: angle)
                self.targetView.transform = transform
            }
            .duration(10)
            .ease(Linear.ease)
            .options(.repeat(1))
            .updateTotal { [unowned self] value in
                self.tweenControls.progress(value)
            }
            .complete { [unowned self] in
                self.tweenControls.stop()
            }
    }
    
    func drawPath(_ path: UIBezierPath) {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shape)
    }
    
    func raceTrack(_ rect:CGRect) -> [CGPoint] {
        
        let startPoint = CGPoint(x: rect.minX, y: rect.minY)
        self.targetView.center = startPoint
        
        var points = [CGPoint]()
        points.append(startPoint)
        points.append(CGPoint(x: rect.midX, y: rect.midY))
        points.append(CGPoint(x: rect.minX, y: rect.maxY))
        points.append(CGPoint(x: rect.maxX, y: rect.maxY))
        points.append(CGPoint(x: rect.maxX, y: rect.minY))
        
        return points
    }
}

