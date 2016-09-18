//
//  Back.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class Back: Ease {
    /**
     Back ease in.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func easeIn(t: Double, b: Double, c: Double, d: Double) -> Double {
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
    open class func easeOut(t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        let s = 1.70158
        t=t/d-1
        let f = (s+1)*t + s
        return c*(t*t*f + 1) + b
    }
    
    /**
     Back ease in out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func easeInOut(t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        var s = 1.70158
        t/=d/2
        if (t < 1) { s*=(1.525); return c/2*(t*t*(((s)+1)*t - s)) + b }
        t-=2
        let postFix = t
        s*=(1.525)
        let f = (s+1)*t + s
        return c/2*(postFix*t*f + 2) + b
    }
}
