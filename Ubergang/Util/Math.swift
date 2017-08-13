//
//  Math.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 15/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

class Math {
    class func clamp<T: Comparable>(_ value: T, lower: T, upper: T) -> T {
        return max(lower, min(value, upper))
    }
    
    class func mapValueInRange(_ value: Double, fromLower: Double, fromUpper: Double, toLower: Double, toUpper: Double) -> Double {
        let fromRangeSize = fromUpper - fromLower
        let toRangeSize = toUpper - toLower
        let valueScale = (value - fromLower) / fromRangeSize
        return toLower + (valueScale * toRangeSize)
    }
    
    class func zigZag(_ x: Double) -> Double {
        return 1 / .pi * asin(cos(Double.pi * (x + 1))) + 0.5
    }
}
