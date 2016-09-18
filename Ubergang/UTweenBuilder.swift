//
//  UTweenBuilder.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 04/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

open class UTweenBuilder {
    
    /**
     Build a `NumericTween`.
     
     Tweens any value with type T implementing the protocol `Numeric` from start to end.
     
     - Parameter to: The end value
     - Parameter from: A closure returning the start value
     - Parameter update: A closure containing the value on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func to<T: Numeric>(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (_ value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to<T: Numeric>(_ to: T, from: @escaping () -> T, update: @escaping (_ value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to<T: Numeric>(_ to: @escaping () -> T, from: T, update: @escaping (_ value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to<T: Numeric>(_ to: T, from: T, update: @escaping (_ value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    /**
     Build a `NumericTween`.
     
     Tweens any value with type T implementing the protocol `Numeric` from start to end.
     
     - Parameter to: The end value
     - Parameter from: A closure returning the start value
     - Parameter update: A closure containing the value and progress on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func to<T: Numeric>(_ to: @escaping () -> T, from: @escaping () -> T, update: @escaping (_ value: T, _ progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to<T: Numeric>(_ to: T, from: @escaping () -> T, update: @escaping (_ value: T, _ progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to<T: Numeric>(_ to: @escaping () -> T, from: T, update: @escaping (_ value: T, _ progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to<T: Numeric>(_ to: T, from: T, update: @escaping (_ value: T, _ progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    
    
    
    
    /**
     Build a `TransformTween`.
     
     Tweens a `CGAffineTransform` from start to end.
     
     - Parameter to: The end value
     - Parameter from: A closure returning the start value
     - Parameter update: A closure containing the value on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func to(_ to: @escaping () -> CGAffineTransform, from: @escaping () -> CGAffineTransform, update: @escaping (_ value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: CGAffineTransform, from: @escaping () -> CGAffineTransform, update: @escaping (_ value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: @escaping () -> CGAffineTransform, from: CGAffineTransform, update: @escaping (_ value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: CGAffineTransform, from: CGAffineTransform, update: @escaping (_ value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    /**
     Build a `TransformTween`.
     
     Tweens a `CGAffineTransform` from start to end.
     
     - Parameter to: The end value
     - Parameter from: A closure returning the start value
     - Parameter update: A closure containing the value and progress on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func to(_ to: @escaping () -> CGAffineTransform, from: @escaping () -> CGAffineTransform, update: @escaping (_ value: CGAffineTransform, _ progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: CGAffineTransform, from: @escaping () -> CGAffineTransform, update: @escaping (_ value: CGAffineTransform, _ progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: @escaping () -> CGAffineTransform, from: CGAffineTransform, update: @escaping (_ value: CGAffineTransform, _ progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: CGAffineTransform, from: CGAffineTransform, update: @escaping (_ value: CGAffineTransform, _ progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    
    
    
    
    /**
     Build a 'ColorTween'.
     
     Tweens a `UIColor` from start to end.
     
     - Parameter to: The end value
     - Parameter from: A closure returning the start value
     - Parameter update: A closure containing the value on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func to(_ to: @escaping () -> UIColor, from: @escaping () -> UIColor, update: @escaping (_ value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: UIColor, from: @escaping () -> UIColor, update: @escaping (_ value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: @escaping () -> UIColor, from: UIColor, update: @escaping (_ value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: UIColor, from: UIColor, update: @escaping (_ value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    
    /**
     Build a 'ColorTween'.
     
     Tweens a `UIColor` from start to end.
     
     - Parameter to: The end value
     - Parameter from: A closure returning the start value
     - Parameter update: A closure containing the value and progress on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func to(_ to: @escaping () -> UIColor, from: @escaping () -> UIColor, update: @escaping (_ value: UIColor, _ progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: UIColor, from: @escaping () -> UIColor, update: @escaping (_ value: UIColor, _ progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: @escaping () -> UIColor, from: UIColor, update: @escaping (_ value: UIColor, _ progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: UIColor, from: UIColor, update: @escaping (_ value: UIColor, _ progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    
    
    
    
    
    
    /**
     Build a 'CGPointTween'.
     
     Tweens a `CGPoint` from start to end.
     
     - Parameter to: The end value
     - Parameter from: A closure returning the start value
     - Parameter update: A closure containing the value and progress on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func to(_ to: @escaping () -> CGPoint, from: @escaping () -> CGPoint, update: @escaping (_ value: CGPoint) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: CGPoint, from: @escaping () -> CGPoint, update: @escaping (_ value: CGPoint) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: @escaping () -> CGPoint, from: CGPoint, update: @escaping (_ value: CGPoint) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: CGPoint, from: CGPoint, update: @escaping (_ value: CGPoint) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    /**
     Build a 'CGPointTween'.
     
     Tweens a `CGPoint` from start to end.
     
     - Parameter to: The end value
     - Parameter from: A closure returning the start value
     - Parameter update: A closure containing the value and progress on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func to(_ to: @escaping () -> CGPoint, from: @escaping () -> CGPoint, update: @escaping (_ value: CGPoint, _ progress: Double) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: CGPoint, from: @escaping () -> CGPoint, update: @escaping (_ value: CGPoint, _ progress: Double) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: @escaping () -> CGPoint, from: CGPoint, update: @escaping (_ value: CGPoint, _ progress: Double) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    open class func to(_ to: CGPoint, from: CGPoint, update: @escaping (_ value: CGPoint, _ progress: Double) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    
    
    
    
    /**
     Build a 'BezierPathTween'.
     
     Tweens the value along a `UIBezierPath` from start to end.
     
     - Parameter path: The bezier path
     - Parameter update: A closure containing the value on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func along(_ path: UIBezierPath, update: @escaping (_ value: CGPoint) -> Void, duration: Double, id: String) -> BezierPathTween {
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
    
    /**
     Build a 'BezierPathTween'.
     
     Tweens the value along a `UIBezierPath` from start to end.
     
     - Parameter path: The bezier path
     - Parameter update: A closure containing the value and progress on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func along(_ path: UIBezierPath, update: @escaping (_ value: CGPoint, _ progress: Double) -> Void, duration: Double, id: String) -> BezierPathTween {
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
    
    /**
     Build a 'BezierPathTween'.
     
     Tweens the value along a `UIBezierPath` from start to end.
     
     - Parameter path: The bezier path
     - Parameter update: A closure containing the value, progress and orientation on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func along(_ path: UIBezierPath, update: @escaping (_ value: CGPoint, _ progress: Double, _ orientation: CGPoint) -> Void, duration: Double, id: String) -> BezierPathTween {
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
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
    open class func along(_ points: [CGPoint], update: @escaping (_ value: CGPoint) -> Void, duration: Double, id: String, closed: Bool = false) -> BezierPathTween {
        
        let numbers = points.map { NSValue(cgPoint: $0) }
        let path = UIBezierPath.interpolateCGPoints(withCatmullRom: numbers, closed: closed, alpha: 1.0)!
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
    
    /**
     Build a 'BezierPathTween'.
     
     Tweens the value along a `UIBezierPath` from start to end. The path will go curve through the given points.
     
     - Parameter points: The points where the path will curve through
     - Parameter update: A closure containing the value and progress on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func along(_ points: [CGPoint], update: @escaping (_ value: CGPoint, _ progress: Double) -> Void, duration: Double, id: String, closed: Bool = false) -> BezierPathTween {
        
        let numbers = points.map { NSValue(cgPoint: $0) }
        let path = UIBezierPath.interpolateCGPoints(withCatmullRom: numbers, closed: closed, alpha: 1.0)!
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
    
    /**
     Build a 'BezierPathTween'.
     
     Tweens the value along a `UIBezierPath` from start to end. The path will go curve through the given points.
     
     - Parameter points: The points where the path will curve through
     - Parameter update: A closure containing the value, progress and orientation on update
     - Parameter duration: The duration of the Tween
     - Parameter id: The unique id of the Tween
     - Returns: The built Tween
     */
    open class func along(_ points: [CGPoint], update: @escaping (_ value: CGPoint, _ progress: Double, _ orientation: CGPoint) -> Void, duration: Double, id: String, closed: Bool = false) -> BezierPathTween {
        
        let numbers = points.map { NSValue(cgPoint: $0) }
        let path = UIBezierPath.interpolateCGPoints(withCatmullRom: numbers, closed: closed, alpha: 1.0)!
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
}
