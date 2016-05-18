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
        
        
        let currentValue = current()
        let path = currentValue.CGPath
        
        let firstElement = path.getElement(0)
        
        let currentSegmentIndex = Int(value * Double(currentValue.CGPath.elementCount()))
        let element = path.getSegment(currentSegmentIndex)
        
        
        var mapped = Math.mapValueInRange(value,
                                          fromLower: (Double(currentSegmentIndex)) / Double(path.getSegments().count), fromUpper: (Double(currentSegmentIndex + 1)) / Double(path.getSegments().count),
                                          toLower: 0.0, toUpper: 1.0)
        mapped = Math.clamp(mapped, lower: 0.0, upper: 1.0)
        
        
        if element.type == .AddCurveToPoint {
            let p0 = firstElement.points[0]
            let p1 = element.points[0]
            let p2 = element.points[1]
            let p3 = element.points[2]
            
            let x = Bezier.interpolation(t: CGFloat(mapped), a: p0.x, b: p1.x, c: p2.x, d: p3.x)
            let y = Bezier.interpolation(t: CGFloat(mapped), a: p0.y, b: p1.y, c: p2.y, d: p3.y)
            
            return CGPoint(x: x, y: y)
        }
        
        return CGPointZero
        
        
        
        
//        var resultPoint: CGPoint = CGPointZero
//        var p0: CGPoint?
//        var index = 0
//        var lastPoint: CGPoint = CGPointZero
//        currentValue.CGPath.forEach { element in
//            
//            var mapped = Math.mapValueInRange(value,
//                fromLower: (Double(index)) / Double(elementCount), fromUpper: (Double(index + 1)) / Double(elementCount),
//                toLower: 0.0, toUpper: 1.0)
//            mapped = Math.clamp(mapped, lower: 0.0, upper: 1.0)
//            
//            
//            
//            switch (element.type) {
//            case CGPathElementType.MoveToPoint:
//                let p1 = element.points[0]
//                lastPoint = p1
//                resultPoint = lastPoint
//            case .AddLineToPoint:
//                let p1 = element.points[0]
//                
//                if mapped > 0.0 && mapped < 1.0 {
//                    if let p0 = p0 {
//                        let p0Vector = GLKVector2Make(Float(p0.x), Float(p0.y))
//                        let p1Vector = GLKVector2Make(Float(p1.x), Float(p1.y))
//                        
//                        let diffVector = GLKVector2Subtract(p0Vector, p1Vector)
//                        let resultVector = GLKVector2MultiplyScalar(diffVector, Float(mapped))
//                        
//                        resultPoint.x = CGFloat(resultVector.x)
//                        resultPoint.y = CGFloat(resultVector.y)
//                    }
//                    
//                    print("AddLineToPoint: \(resultPoint)")
//                }
//                
//                lastPoint = p1
//            case .AddQuadCurveToPoint:
//                let p1 = element.points[0]
//                let p2 = element.points[1]
//                lastPoint = p2
//            case .AddCurveToPoint:
//                let p1 = element.points[0]
//                let p2 = element.points[1]
//                let p3 = element.points[2]
//                lastPoint = p3
//                
//                if mapped > 0.0 && mapped < 1.0 {
//                    if let p0 = p0 {
//                        let x = Bezier.interpolation(t: CGFloat(mapped), a: p0.x, b: p1.x, c: p2.x, d: p3.x)
//                        let y = Bezier.interpolation(t: CGFloat(mapped), a: p0.y, b: p1.y, c: p2.y, d: p3.y)
//                        resultPoint.x = x
//                        resultPoint.y = y
//                    }
//                    print("AddCurveToPoint: \(resultPoint)")
//                }
//                index += 1
//            case .CloseSubpath:
//                print("close()")
//            }
//            
//            if value >= 1.0 {
//                resultPoint = lastPoint
//            }
//            
//            
//            p0 = lastPoint
//        }
//        
//        
//        return resultPoint
    }
    
    
    
    
    
    
    
    public func to(to: UIBezierPath, current: () -> UIBezierPath, update: (CGPoint) -> Void) -> Self {
        
        self.current(current)
            .update(update)
        
        return self
    }
    
    public func to(to: UIBezierPath, current: () -> UIBezierPath, update: (CGPoint, Double) -> Void) -> Self {
        
        self.current(current)
            .update(update)
        
        return self
    }
    
    public func to(to: UIBezierPath, current: () -> UIBezierPath, update: (CGPoint) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, current: current, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(to: UIBezierPath, current: () -> UIBezierPath, update: (CGPoint, Double) -> Void, complete: () -> Void) -> Self {
        
        self.to(to, current: current, update: update)
            .complete(complete)
        
        return self
    }
    
    public func to(to: UIBezierPath, current: () -> UIBezierPath, update: (CGPoint) -> Void, duration: Double) -> Self {
        
        self.to(to, current: current, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: UIBezierPath, current: () -> UIBezierPath, update: (CGPoint, Double) -> Void, duration: Double) -> Self {
        
        self.to(to, current: current, update: update)
            .duration(duration)
        
        return self
    }
    
    public func to(to: UIBezierPath, current: () -> UIBezierPath, update: (CGPoint) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, current: current, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    public func to(to: UIBezierPath, current: () -> UIBezierPath, update: (CGPoint, Double) -> Void, complete: () -> Void, duration: Double) -> Self {
        
        self.to(to, current: current, update: update, complete:  complete)
            .duration(duration)
        
        return self
    }
    
    
    public func current(value: () -> UIBezierPath) -> Self {
        current = value
        
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


extension CGPath {
    func forEach(@noescape body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        func callback(info: UnsafeMutablePointer<Void>, element: UnsafePointer<CGPathElement>) {
            let body = unsafeBitCast(info, Body.self)
            body(element.memory)
        }
        let unsafeBody = unsafeBitCast(body, UnsafeMutablePointer<Void>.self)
        CGPathApply(self, unsafeBody, callback)
    }
    
    func getElements() -> [CGPathElement] {
        var elements = [CGPathElement]()
        forEach { element in
            switch (element.type) {
            case CGPathElementType.MoveToPoint:
                elements.append(element)
            case .AddLineToPoint:
                elements.append(element)
            case .AddQuadCurveToPoint:
                elements.append(element)
            case .AddCurveToPoint:
                elements.append(element)
            case .CloseSubpath:
                print("close()")
            }
        }
        
        return elements
    }

    func getSegments() -> [CGPathElement] {
        var elements = [CGPathElement]()
        forEach { element in
            switch (element.type) {
            case CGPathElementType.MoveToPoint:
                break
            case .AddLineToPoint:
                elements.append(element)
            case .AddQuadCurveToPoint:
                elements.append(element)
            case .AddCurveToPoint:
                elements.append(element)
            case .CloseSubpath:
                break
            }
        }
        
        return elements
    }

    func getElement(index: Int) -> CGPathElement {
        return getElements()[index]
    }
    
    func getSegment(index: Int) -> CGPathElement {
        return getSegments()[index]
    }
    
    func elementCount() -> Int {
        var count = 0
        self.forEach { element in
            if element.type != .MoveToPoint && element.type != .CloseSubpath {
                count += 1
            }
        }
        return count
    }
}