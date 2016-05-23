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
            let pr = Bezier.linear(t: CGFloat(mapped),
                                   p0: element.points[0],
                                   p1: element.points[1])
            
            return CGPoint(x: pr.x, y: pr.y)
        case .AddQuadCurveToPoint:
            let pr = Bezier.quad(t: CGFloat(mapped),
                                 p0: element.points[0],
                                 p1: element.points[1],
                                 p2: element.points[2])
            
            return CGPoint(x: pr.x, y: pr.y)
        case .AddCurveToPoint:
            let pr = Bezier.cubic(t: CGFloat(mapped),
                                  p0: element.points[0],
                                  p1: element.points[1],
                                  p2: element.points[2],
                                  p3: element.points[3])
            
            return CGPoint(x: pr.x, y: pr.y)
        case .CloseSubpath:
            let pr = Bezier.linear(t: CGFloat(mapped),
                                   p0: element.points[0],
                                   p1: element.points[1])
            
            return CGPoint(x: pr.x, y: pr.y)
        }
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