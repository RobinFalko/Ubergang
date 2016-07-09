//
//  Expo.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Expo: Ease {
    
    /**
     Expo ease in.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeIn(t t: Double, b: Double, c: Double, d: Double) -> Double {
        return (t==0) ? b : c * pow(2, 10 * (t/d - 1)) + b
    }
    
    /**
     Circ ease out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        return (t==d) ? b+c : c * (-pow(2, -10 * t/d) + 1) + b
    }
    
    /**
     Circ ease in out.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func easeInOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        if (t==0) { return b }
        if (t==d) { return b+c }
        t/=d/2
        if ((t) < 1) { return c/2 * pow(2, 10 * (t - 1)) + b }
        t-=1
        return c/2 * (-pow(2, -10 * t) + 2) + b
    }
}