//
//  Back.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Back: Ease {
    /**
     Back ease in.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeIn(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        let s = 1.70158
        t/=d
        let postFix = t
        return c*(postFix)*t*((s+1)*t - s) + b
    }
    
    /**
     Back ease out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        let s = 1.70158
        t=t/d-1
        return c*(t*t*((s+1)*t + s) + 1) + b
    }
    
    /**
     Back ease in out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeInOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        var s = 1.70158
        t/=d/2
        if (t < 1) { s*=(1.525); return c/2*(t*t*(((s)+1)*t - s)) + b }
        t-=2
        let postFix = t
        s*=(1.525)
        return c/2*((postFix)*t*(((s)+1)*t + s) + 2) + b
    }
}