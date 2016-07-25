//
//  UTweenBuilder.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 04/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

public class UTweenBuilder {
    
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
    public class func to<T: Numeric>(to: () -> T, from: () -> T, update: (value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to<T: Numeric>(to: T, from: () -> T, update: (value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to<T: Numeric>(to: () -> T, from: T, update: (value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to<T: Numeric>(to: T, from: T, update: (value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
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
    public class func to<T: Numeric>(to: () -> T, from: () -> T, update: (value: T, progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to<T: Numeric>(to: T, from: () -> T, update: (value: T, progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to<T: Numeric>(to: () -> T, from: T, update: (value: T, progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to<T: Numeric>(to: T, from: T, update: (value: T, progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
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
    public class func to(to: () -> CGAffineTransform, from: () -> CGAffineTransform, update: (value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: CGAffineTransform, from: () -> CGAffineTransform, update: (value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: () -> CGAffineTransform, from: CGAffineTransform, update: (value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: CGAffineTransform, from: CGAffineTransform, update: (value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
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
    public class func to(to: () -> CGAffineTransform, from: () -> CGAffineTransform, update: (value: CGAffineTransform, progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: CGAffineTransform, from: () -> CGAffineTransform, update: (value: CGAffineTransform, progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: () -> CGAffineTransform, from: CGAffineTransform, update: (value: CGAffineTransform, progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: CGAffineTransform, from: CGAffineTransform, update: (value: CGAffineTransform, progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
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
    public class func to(to: () -> UIColor, from: () -> UIColor, update: (value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: UIColor, from: () -> UIColor, update: (value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: () -> UIColor, from: UIColor, update: (value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: UIColor, from: UIColor, update: (value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
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
    public class func to(to: () -> UIColor, from: () -> UIColor, update: (value: UIColor, progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: UIColor, from: () -> UIColor, update: (value: UIColor, progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: () -> UIColor, from: UIColor, update: (value: UIColor, progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: UIColor, from: UIColor, update: (value: UIColor, progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
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
    public class func to(to: () -> CGPoint, from: () -> CGPoint, update: (value: CGPoint) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: CGPoint, from: () -> CGPoint, update: (value: CGPoint) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: () -> CGPoint, from: CGPoint, update: (value: CGPoint) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: CGPoint, from: CGPoint, update: (value: CGPoint) -> Void, duration: Double, id: String) -> CGPointTween {
        
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
    public class func to(to: () -> CGPoint, from: () -> CGPoint, update: (value: CGPoint, progress: Double) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: CGPoint, from: () -> CGPoint, update: (value: CGPoint, progress: Double) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: () -> CGPoint, from: CGPoint, update: (value: CGPoint, progress: Double) -> Void, duration: Double, id: String) -> CGPointTween {
        
        let tween = CGPointTween(id: id)
        return tween.to( to, from: from, update: update, duration: duration )
    }
    
    public class func to(to: CGPoint, from: CGPoint, update: (value: CGPoint, progress: Double) -> Void, duration: Double, id: String) -> CGPointTween {
        
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
    public class func along(path: UIBezierPath, update: (value: CGPoint) -> Void, duration: Double, id: String) -> BezierPathTween {
        
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
    public class func along(path: UIBezierPath, update: (value: CGPoint, progress: Double) -> Void, duration: Double, id: String) -> BezierPathTween {
        
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
    public class func along(path: UIBezierPath, update: (value: CGPoint, progress: Double, orientation: CGPoint) -> Void, duration: Double, id: String) -> BezierPathTween {
        
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
    public class func along(points: [CGPoint], update: (value: CGPoint) -> Void, duration: Double, id: String, closed: Bool = false) -> BezierPathTween {
        
        let numbers = points.map { NSValue(CGPoint: $0) }
        let path = UIBezierPath.interpolateCGPointsWithCatmullRom(numbers, closed: closed, alpha: 1.0)
        
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
    public class func along(points: [CGPoint], update: (value: CGPoint, progress: Double) -> Void, duration: Double, id: String, closed: Bool = false) -> BezierPathTween {
        
        let numbers = points.map { NSValue(CGPoint: $0) }
        let path = UIBezierPath.interpolateCGPointsWithCatmullRom(numbers, closed: closed, alpha: 1.0)
        
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
    public class func along(points: [CGPoint], update: (value: CGPoint, progress: Double, orientation: CGPoint) -> Void, duration: Double, id: String, closed: Bool = false) -> BezierPathTween {
        
        let numbers = points.map { NSValue(CGPoint: $0) }
        let path = UIBezierPath.interpolateCGPointsWithCatmullRom(numbers, closed: closed, alpha: 1.0)
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
}
