//
//  BezierPathTween.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
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
    var elements: [(type: CGPathElementType, points: [CGPoint])]!
    
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
        
        var currentSegmentIndex = 0
        var currentDistance: Double = 0
        var lower: Double = 0
        var upper: Double = 0
        for i in 0..<elements.count {
            currentDistance = value * Double(pathInfo!.1)
            upper = (Double(pathInfo!.0[i]))
            
            if currentDistance <= lower + upper {
                currentSegmentIndex = i
                break
            }
            
            lower += (Double(pathInfo!.0[i]))
        }
        
        let element = elements[currentSegmentIndex]
        
        let mapped = Math.mapValueInRange(currentDistance,
                                          fromLower: lower, fromUpper: lower + upper,
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
        
        elements = path.CGPath.getElements()
        pathInfo = computeDistances(elements)
        
        self.update(update)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint, Double) -> Void) -> Self {
        self.path = path
        
        elements = path.CGPath.getElements()
        pathInfo = computeDistances(elements)   
        
        self.update(update)
        
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
    
    func computeDistances(elements: [(type: CGPathElementType, points: [CGPoint])]) -> (distanceElements: [Float], distanceSum: Float) {
        var pr = CGPointZero
        var currentV = GLKVector2(v: (0, 0))
        var previousV = GLKVector2(v: (0, 0))
        var distanceSum: Float = 0
        var distanceElements = [Float]()
        
        let interval = 10000
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
        }
        
        return (distanceElements, distanceSum)
    }
}