//
//  UTweenBuilder.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 04/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

public class UTweenBuilder {
    
    public class func to<T: Numeric>(to: T, current: () -> T, update: (value: T) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, current: current, update: update, duration: duration )
    }
    
    public class func to<T: Numeric>(to: T, current: () -> T, update: (value: T, progress: Double) -> Void, duration: Double, id: String) -> NumericTween<T> {
        
        let tween = NumericTween<T>(id: id)
        return tween.to( to, current: current, update: update, duration: duration )
    }
    
    
    
    
    public class func to(to: CGAffineTransform, current: () -> CGAffineTransform, update: (value: CGAffineTransform) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, current: current, update: update, duration: duration )
    }
    
    public class func to(to: CGAffineTransform, current: () -> CGAffineTransform, update: (value: CGAffineTransform, progress: Double) -> Void, duration: Double, id: String) -> TransformTween {
        
        let tween = TransformTween(id: id)
        return tween.to( to, current: current, update: update, duration: duration )
    }
    
    
    
    
    public class func to(to: UIColor, current: () -> UIColor, update: (value: UIColor) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, current: current, update: update, duration: duration )
    }
    
    public class func to(to: UIColor, current: () -> UIColor, update: (value: UIColor, progress: Double) -> Void, duration: Double, id: String) -> ColorTween {
        
        let tween = ColorTween(id: id)
        return tween.to( to, current: current, update: update, duration: duration )
    }
    
    
    
    
    public class func along(path: UIBezierPath, update: (value: CGPoint) -> Void, duration: Double, id: String) -> BezierPathTween {
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
    
    public class func along(path: UIBezierPath, update: (value: CGPoint, progress: Double) -> Void, duration: Double, id: String) -> BezierPathTween {
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
    
    
    
    
    public class func along(points: [CGPoint], update: (value: CGPoint) -> Void, duration: Double, id: String, closed: Bool = false) -> BezierPathTween {
        
        let numbers = points.map { NSValue(CGPoint: $0) }
        let path = UIBezierPath.interpolateCGPointsWithCatmullRom(numbers, closed: closed, alpha: 1.0)
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
    
    public class func along(points: [CGPoint], update: (value: CGPoint, progress: Double) -> Void, duration: Double, id: String, closed: Bool = false) -> BezierPathTween {
        
        let numbers = points.map { NSValue(CGPoint: $0) }
        let path = UIBezierPath.interpolateCGPointsWithCatmullRom(numbers, closed: closed, alpha: 1.0)
        
        let tween = BezierPathTween(id: id)
        return tween.along( path, update: update, duration: duration )
    }
}
