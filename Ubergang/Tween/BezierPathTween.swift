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
    
    var offset: Double?
    
    var current: (() -> UIBezierPath)!
    var updateValue: ((value: CGPoint) -> Void)!
    var updateValueAndProgress: ((value: CGPoint, progress: Double) -> Void)!
    var updateValueAndProgressAndOrientation: ((value: CGPoint, progress: Double, orientation: CGPoint) -> Void)!
    
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
            
            //if an offset is set, add it to the current ease value
            if let offset = offset {
                easeValue = fmod(easeValue + offset, 1.0)
            }
            
            let computedValue = compute(easeValue)
            
            //call update closures if set
            updateValue?( value: computedValue )
            updateValueAndProgress?( value: computedValue, progress: newValue )
            updateValueAndProgressAndOrientation?( value: computedValue, progress: newValue, orientation: orientation ?? CGPointZero  )
            
            super.progress = newValue
        }
        get {
            return time / duration
        }
    }
    
    var previousPoint: CGPoint?
    var orientation: CGPoint?
    
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
        var newPoint:CGPoint!
        
        switch element.type {
        case .MoveToPoint:
            newPoint = element.points[0]
        case .AddLineToPoint:
            newPoint = Bezier.linear(t: CGFloat(mapped),
                                   p0: element.points[0],
                                   p1: element.points[1])
        case .AddQuadCurveToPoint:
            newPoint = Bezier.quad(t: CGFloat(mapped),
                                 p0: element.points[0],
                                 p1: element.points[1],
                                 p2: element.points[2])
        case .AddCurveToPoint:
            newPoint = Bezier.cubic(t: CGFloat(mapped),
                                  p0: element.points[0],
                                  p1: element.points[1],
                                  p2: element.points[2],
                                  p3: element.points[3])
        case .CloseSubpath:
            newPoint = Bezier.linear(t: CGFloat(mapped),
                                   p0: element.points[0],
                                   p1: element.points[1])
        }
        
        //calculate the orientation vector from one vector to the other, 
        //but only if these vectors are not equal
        if let previousPoint = previousPoint where previousPoint != newPoint  {
            let v0 = GLKVector2(v: (Float(newPoint.x), Float(newPoint.y)))
            let v1 = GLKVector2(v: (Float(previousPoint.x), Float(previousPoint.y)))
            var vDirection = GLKVector2Subtract(v0, v1)
            vDirection = GLKVector2Normalize(vDirection)
            orientation = CGPoint(x: CGFloat(vDirection.x), y: CGFloat(vDirection.y))
        }
        
        previousPoint = newPoint
        
        return newPoint
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
    
    public func along(path: UIBezierPath, update: (CGPoint, Double, CGPoint) -> Void) -> Self {
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
    
    public func along(path: UIBezierPath, update: (CGPoint, Double, CGPoint) -> Void, complete: () -> Void) -> Self {
        
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
    
    public func along(path: UIBezierPath, update: (CGPoint, Double, CGPoint) -> Void, duration: Double) -> Self {
        
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
    
    public func along(path: UIBezierPath, update: (CGPoint, Double, CGPoint) -> Void, complete: () -> Void, duration: Double) -> Self {
        
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
    
    
    public func update(value: (CGPoint, Double, CGPoint) -> Void) -> Self {
        updateValueAndProgressAndOrientation = value
        
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
    
    public func offset(value: Double) -> Self {
        self.offset = value
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