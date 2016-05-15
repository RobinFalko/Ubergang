//
//  UTweenBuilder.swift
//  Ubergang
//
//  Created by RF on 04/04/16.
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
}
