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
    
    var previousElement: (index: Int, type: CGPathElementType, point:CGPoint)?
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
        
        if element.type == .AddLineToPoint {
            let p0 = element.points[0]
            let p1 = element.points[1]
            
            let p0Vector = GLKVector2Make(Float(p0.x), Float(p0.y))
            let p1Vector = GLKVector2Make(Float(p1.x), Float(p1.y))

            let diffVector = GLKVector2Subtract(p1Vector, p0Vector)
            let resultVector = GLKVector2MultiplyScalar(diffVector, Float(mapped))

            let x = p0.x + CGFloat(resultVector.x)
            let y = p0.y + CGFloat(resultVector.y)
            
            return CGPoint(x: x, y: y)
        }
        
        if element.type == .AddCurveToPoint {
            let p0 = element.points[0]
            let p1 = element.points[1]
            let p2 = element.points[2]
            let p3 = element.points[3]
            
            let x = Bezier.interpolation(t: CGFloat(mapped), a: p0.x, b: p1.x, c: p2.x, d: p3.x)
            let y = Bezier.interpolation(t: CGFloat(mapped), a: p0.y, b: p1.y, c: p2.y, d: p3.y)
            
            return CGPoint(x: x, y: y)
        }
        
        //needs more love
//        if element.type == .CloseSubpath {
//            let p0 = path.getElement(0)!.points.first!
//            let p1 = element.points[0]
//            
//            let p0Vector = GLKVector2Make(Float(p0.x), Float(p0.y))
//            let p1Vector = GLKVector2Make(Float(p1.x), Float(p1.y))
//            
//            let diffVector = GLKVector2Subtract(p1Vector, p0Vector)
//            let resultVector = GLKVector2MultiplyScalar(diffVector, Float(mapped))
//            
//            let x = p0.x + CGFloat(resultVector.x)
//            let y = p0.y + CGFloat(resultVector.y)
//            
//            return CGPoint(x: x, y: y)
//        }
        
        return element.points[0]
    }
    
    var path: UIBezierPath!
    public func along(path: UIBezierPath, update: (CGPoint) -> Void) -> Self {
        self.path = path
        print("set path \(path)")
        
        self.update(update)
        
        return self
    }
    
    public func along(path: UIBezierPath, update: (CGPoint, Double) -> Void) -> Self {
        self.path = path
        print("set path \(path)")
        
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
}