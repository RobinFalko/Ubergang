//
//  Bounce.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class Bounce: Easing, CurveEasing {
    
    /**
     Bounce ease in.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func easeIn(t: Double, b: Double, c: Double, d: Double) -> Double {
        return c - easeOut (t: d-t, b: 0, c: c, d: d) + b
    }
    
    /**
     Bounce ease out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func easeOut(t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        t/=d
        if t < (1/2.75) {
            return c*(7.5625*t*t) + b
        } else if (t < (2/2.75)) {
            t-=(1.5/2.75)
            let postFix = t
            return c*(7.5625*(postFix)*t + 0.75) + b
        } else if (t < (2.5/2.75)) {
            t-=(2.25/2.75)
            let postFix = t
            return c*(7.5625*(postFix)*t + 0.9375) + b
        } else {
            t-=(2.625/2.75)
            let postFix = t
            return c*(7.5625*(postFix)*t + 0.984375) + b
        }
    }
    
    /**
     Bounce ease in out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func easeInOut(t: Double, b: Double, c: Double, d: Double) -> Double {
        if (t < d/2) { return easeIn (t: t*2, b: 0, c: c, d: d) * 0.5 + b }
        else { return easeOut (t: t*2-d, b: 0, c: c, d: d) * 0.5 + c*0.5 + b }
    }
}
