//
//  Back.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Back: Ease {
    
    public class func easeIn(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        let s = 1.70158
        t/=d
        let postFix = t
        return c*(postFix)*t*((s+1)*t - s) + b
    }
    
    public class func easeOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        var t = t
        let s = 1.70158
        t=t/d-1
        return c*(t*t*((s+1)*t + s) + 1) + b
    }
    
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