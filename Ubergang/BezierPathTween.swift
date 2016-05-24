//
//  ColorTween.swift
//  Tween
//
//  Created by RF on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit
import GLKit

public class BezierPathTween: UTweenBase {
    
    var current: (() -> UIBezierPath)!
    var updateValue: ((value: CGPoint) -> Void)!
    var updateValueAndProgress: ((value: CGPoint, progress: Double) -> Void)!
    
    var pathInfo: ([Float], Float)?
    
    public convenience init() {
        let id = "\(#file)_\(random() * 1000)_update"
        self.init(id: id)
    }
    
    public override init(id: String) {
        super.init(id: id)
    }
    
    override public var progress: Double {
        set {
            time = newValue * duration
            
            easeValue = ease(t: time, b: 0.0, c: 1.0, d: duration)
            
            updateValue?( value: compute(easeValue) )
            updateValueAndProgress?( value: compute(easeValue), progress: newValue )
            
            super.progress = newValue
        }
        get {
            return time / duration
        }
    }
    
    func compute(value: Double) -> CGPoint {
        
        let path = self.path.CGPath
        let currentSegmentIndex = Int(value * Double(path.getElements().count))
        
        let tmpElement = path.getElement(currentSegmentIndex)
        guard let element = tmpElement else {
            //what if the path closes? Rethink this issue
            return path.getElement(currentSegmentIndex - 1)!.points.last!
        }
        
        let mapped = Math.mapValueInRange(value,
                                          fromLower: (Double(currentSegmentIndex)) / Double(path.getElements().count), fromUpper: (Double(currentSegmentIndex + 1)) / Double(path.getElements().count),
                                          toLower: 0.0, toUpper: 1.0)
        
        
        switch element.type {
        case .MoveToPoint:
            return element.points[0]
        case .AddLineToPoint:
            return Bezier.linear(t: CGFloat(mapped),
                                   p0: element.points[0],
                                   p1: element.points[1])
        case .AddQuadCurveToPoint:
            return Bezier.quad(t: CGFloat(mapped),
                                 p0: element.points[0],
                                 p1: element.points[1],
                                 p2: element.points[2])
        case .AddCurveToPoint:
            return Bezier.cubic(t: CGFloat(mapped),
                                  p0: element.points[0],
                                  p1: element.points[1],
                                  p2: element.points[2],
                                  p3: element.points[3])
        case .CloseSubpath:
            return Bezier.linear(t: CGFloat(mapped),
                                   p0: element.points[0],
                                   p1: element.points[1])
        }
    }
    
    var path: UIBezierPath!
    public func along(path: UIBezierPath, update: (CGPoint) -> Void) -> Self {
        self.path = path
        
        self.update(update)
        
        pathInfo = computeDistances(path.CGPath)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint, Double) -> Void) -> Self {
        self.path = path
        
        self.update(update)
        
        pathInfo = computeDistances(path.CGPath)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint) -> Void, complete: () -> Void) -> Self {
        
        self.along(path, update: update)
            .complete(complete)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint, Double) -> Void, complete: () -> Void) -> Self {
        
        self.along(path, update: update)
            .complete(complete)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint) -> Void, duration: Double) -> Self {
        
        self.along(path, update: update)
            .duration(duration)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint, Double) -> Void, duration: Double) -> Self {
        
        self.along(path, update: update)
            .duration(duration)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.along(path, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint, Double) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.along(path, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    
    public func update(value: (CGPoint) -> Void) -> Self {
        updateValue = value
        
        return self
    }
    
    
    public func update(value: (CGPoint, Double) -> Void) -> Self {
        updateValueAndProgress = value
        
        return self
    }
    
    public func duration(value: Double) -> Self {
        initialDuration = value
        duration = value
        durationTotal = value
        
        return self
    }
    
    public func ease(ease: Easing) -> Self {
        self.ease = ease
        return self
    }
    
    func computeDistances(path: CGPath) -> (distanceElements: [Float], distanceSum: Float) {
        var pr = CGPointZero
        var currentV = GLKVector2(v: (0, 0))
        var previousV = GLKVector2(v: (0, 0))
        var distanceSum: Float = 0
        var distanceElements = [Float]()
        
        let interval = 10000
        let elements = path.getElements()
        for element in elements {
            var distanceElement: Float = 0
            
            for i in 0..<interval {
                let t = Float(i) / Float(interval)
                
                switch element.type {
                case .MoveToPoint:
                    let p = element.points[0]
                    previousV = GLKVector2(v: (Float(p.x), Float(p.y)))
                    
                case .AddLineToPoint:
                    pr = Bezier.linear(t: CGFloat(t),
                                       p0: element.points[0],
                                       p1: element.points[1])
                case .AddQuadCurveToPoint:
                    pr = Bezier.quad(t: CGFloat(t),
                                     p0: element.points[0],
                                     p1: element.points[1],
                                     p2: element.points[2])
                case .AddCurveToPoint:
                    pr = Bezier.cubic(t: CGFloat(t),
                                      p0: element.points[0],
                                      p1: element.points[1],
                                      p2: element.points[2],
                                      p3: element.points[3])
                case .CloseSubpath:
                    pr = Bezier.linear(t: CGFloat(t),
                                       p0: element.points[0],
                                       p1: element.points[1])
                }
                
                
                if GLKVector2Length(previousV) == 0 {
                    let p = element.points[0]
                    previousV = GLKVector2(v: (Float(p.x), Float(p.y)))
                }
                
                currentV = GLKVector2(v: (Float(pr.x), Float(pr.y)))
                distanceElement += GLKVector2Distance(currentV, previousV)
                previousV = currentV
            }
            
            distanceElements.append(distanceElement)
            
            distanceSum += distanceElement
            print("distanceElement \(distanceElement)")
        }
        
        print("distanceSum \(distanceSum)")
        
        return (distanceElements, distanceSum)
    }
}