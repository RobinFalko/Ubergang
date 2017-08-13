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

open class BezierPathTween: UTweenBase {
    
    var offset: Double?
    
    var current: (() -> UIBezierPath)!
    var updateValue: ((_ value: CGPoint) -> Void)!
    var updateValueAndProgress: ((_ value: CGPoint, _ progress: Double) -> Void)!
    var updateValueAndProgressAndOrientation: ((_ value: CGPoint, _ progress: Double, _ orientation: CGPoint) -> Void)!
    
    var pathInfo: ([Float], Float)?
    var elements: [(type: CGPathElementType, points: [CGPoint])]!
    
    /**
     Initialize a generic `UTween` with a random id.
     
     Tweens any value with type T from start to end.
     
     This object needs to know how to compute interpolations from start to end, that for
     `func compute(value: Double) -> T` must be overriden.
     */
    public convenience init() {
        let id = "\(#file)_\(arc4random())_update"
        self.init(id: id)
    }
    
    /**
     Initialize a generic `UTween`.
     
     Tweens any value with type T from start to end.
     
     This object needs to know how to compute interpolations from start to end, that for
     `func compute(value: Double) -> T` must be overriden.
     
     - Parameter id: The unique id of the Tween
     */
    public override init(id: String) {
        super.init(id: id)
    }
    
    override open var progress: Double {
        set {
            time = newValue * duration
            
            easeValue = ease(time, 0.0, 1.0, duration)
            
            //if an offset is set, add it to the current ease value
            if let offset = offset {
                easeValue = fmod(easeValue + offset, 1.0)
            }
            
            let computedValue = compute(easeValue)
            
            //call update closures if set
            updateValue?( computedValue )
            updateValueAndProgress?( computedValue, newValue )
            updateValueAndProgressAndOrientation?( computedValue, newValue, orientation ?? CGPoint.zero  )
            
            super.progress = newValue
        }
        get {
            return time / duration
        }
    }
    
    var previousPoint: CGPoint?
    var orientation: CGPoint?
    
    func compute(_ value: Double) -> CGPoint {
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
        case .moveToPoint:
            newPoint = element.points[0]
        case .addLineToPoint:
            newPoint = Bezier.linear(t: CGFloat(mapped),
                                   p0: element.points[0],
                                   p1: element.points[1])
        case .addQuadCurveToPoint:
            newPoint = Bezier.quad(t: CGFloat(mapped),
                                 p0: element.points[0],
                                 p1: element.points[1],
                                 p2: element.points[2])
        case .addCurveToPoint:
            newPoint = Bezier.cubic(t: CGFloat(mapped),
                                  p0: element.points[0],
                                  p1: element.points[1],
                                  p2: element.points[2],
                                  p3: element.points[3])
        case .closeSubpath:
            newPoint = Bezier.linear(t: CGFloat(mapped),
                                   p0: element.points[0],
                                   p1: element.points[1])
        }
        
        //calculate the orientation vector from one vector to the other, 
        //but only if these vectors are not equal
        if let previousPoint = previousPoint , previousPoint != newPoint  {
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
    
    /**
     Build a 'BezierPathTween'.
     
     Tweens the value along a `UIBezierPath` from start to end.
     
     - Parameter path: The bezier path
     - Parameter update: A closure containing the value on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open func along(_ path: UIBezierPath) -> Self {
        self.path = path
        
        elements = path.cgPath.getElements()
        pathInfo = computeDistances(elements)
        
        return self
    }
    
    /**
     Build a 'BezierPathTween'.
     
     Tweens the value along a `UIBezierPath` from start to end. The path will go curve through the given points.
     
     - Parameter points: The points where the path will curve through
     - Parameter update: A closure containing the value on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open func along(_ points: [CGPoint], closed: Bool = false) -> Self {
        let numbers = points.map { NSValue(cgPoint: $0) }
        self.path = UIBezierPath.interpolateCGPoints(withCatmullRom: numbers, closed: closed, alpha: 1.0)!
        
        elements = path.cgPath.getElements()
        pathInfo = computeDistances(elements)
        
        return self
    }
    
    open func update(_ value: @escaping (CGPoint) -> Void) -> Self {
        updateValue = value
        
        return self
    }
    
    
    open func update(_ value: @escaping (CGPoint, Double) -> Void) -> Self {
        updateValueAndProgress = value
        
        return self
    }
    
    
    open func update(_ value: @escaping (CGPoint, Double, CGPoint) -> Void) -> Self {
        updateValueAndProgressAndOrientation = value
        
        return self
    }
    
    open func ease(_ ease: @escaping Easing) -> Self {
        self.ease = ease
        return self
    }
    
    open func offset(_ value: Double) -> Self {
        self.offset = value
        return self
    }
    
    func computeDistances(_ elements: [(type: CGPathElementType, points: [CGPoint])]) -> (distanceElements: [Float], distanceSum: Float) {
        var pr = CGPoint.zero
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
                case .moveToPoint:
                    let p = element.points[0]
                    previousV = GLKVector2(v: (Float(p.x), Float(p.y)))
                    
                case .addLineToPoint:
                    pr = Bezier.linear(t: CGFloat(t),
                                       p0: element.points[0],
                                       p1: element.points[1])
                case .addQuadCurveToPoint:
                    pr = Bezier.quad(t: CGFloat(t),
                                     p0: element.points[0],
                                     p1: element.points[1],
                                     p2: element.points[2])
                case .addCurveToPoint:
                    pr = Bezier.cubic(t: CGFloat(t),
                                      p0: element.points[0],
                                      p1: element.points[1],
                                      p2: element.points[2],
                                      p3: element.points[3])
                case .closeSubpath:
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
