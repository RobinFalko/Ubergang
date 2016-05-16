//
//  Sine.swift
//  Tween
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Sine: Ease {
    
    public class func easeIn(t t: Double, b: Double, c: Double, d: Double) -> Double {
        return -c * cos(t/d * (M_PI/2)) + c + b
    }
    
    public class func easeOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        return c * sin(t/d * (M_PI/2)) + b
    }
    
    public class func easeInOut(t t: Double, b: Double, c: Double, d: Double) -> Double {
        return -c/2 * (cos(M_PI*t/d) - 1) + b
    }
}