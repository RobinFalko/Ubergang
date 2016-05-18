//
//  Math.swift
//  Ubergang
//
//  Created by RF on 15/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

class Math {
    class func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
        return max(lower, min(value, upper))
    }
    
    class func mapValueInRange(value: Double, fromLower: Double, fromUpper: Double, toLower: Double, toUpper: Double) -> Double {
        let fromRangeSize = fromUpper - fromLower
        let toRangeSize = toUpper - toLower
        let valueScale = (value - fromLower) / fromRangeSize
        return toLower + (valueScale * toRangeSize)
    }
    
    class func zigZag(x: Double) -> Double {
        return 1 / M_PI * asin(cos(M_PI * (x + 1))) + 0.5
    }
}