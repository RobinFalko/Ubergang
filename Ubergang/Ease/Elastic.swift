//
//  Elastic.swift
//  Tween
//
//  Created by RF on 10/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Elastic: Ease {
    
    public class func easeIn(var t t: Double, b: Double, c: Double, d: Double) -> Double {
        if t == 0 {
            return b
        }
        
        t = t / d
        if t == 1 {
            return b+c
        }
        
        let p = d * 0.3
        let a = c
        let s = p / 4
        t = t - 1
        
        let postFix = a * pow(2.0, 10.0 * t) // this is a fix, again, with post-increment operators
        
        return -(postFix * sin((t*d-s) * (2 * M_PI)/p )) + b
    }
    
    public class func easeOut(var t t: Double, b: Double, c: Double, d: Double) -> Double {
        if t == 0 {
            return b
        }
        
        t = t / d
        if t == 1 {
            return b+c
        }
        
        let p = d * 0.3
        let a = c
        let s = p / 4
        
        return (a * pow(2, -10 * t) * sin( (t*d-s) * (2*M_PI)/p ) + c + b)
    }
    
    public class func easeInOut(var t t: Double, b: Double, c: Double, d: Double) -> Double {
        if t == 0 {
            return b
        }
        
        t = t / (d / 2)
        if t == 2 {
            return b+c
        }
        
        let p = d * (0.3*1.5)
        let a = c
        let s = p / 4
        
        t = t - 1
        
        if (t < 1) {
            let postFix = a * pow(2.0, 10.0 * t) // postIncrement is evil
            return -0.5 * (postFix * sin((t*d-s) * (2*M_PI)/p)) + b
        }
        
        let postFix = a * pow(2.0, -10.0 * t) // postIncrement is evil
        return postFix * sin((t*d-s) * (2*M_PI) / p) * 0.5 + c + b
    }
}
