//
//  Circ.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class Circ: Easing, CurveEasing {
    
    /**
     Circ ease in.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func easeIn(t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        t/=d
        return -c * (sqrt(1 - (t)*t) - 1) + b
    }
    
    /**
     Circ ease out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func easeOut(t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        t=t/d-1
        return c * sqrt(1 - (t)*t) + b
    }
    
    /**
     Circ ease in out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func easeInOut(t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        t/=d/2
        if ((t) < 1) { return -c/2 * (sqrt(1 - t*t) - 1) + b }
        t-=2
        return c/2 * (sqrt(1 - t*(t)) + 1) + b
    }
}
