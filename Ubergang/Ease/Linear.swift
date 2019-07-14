//
//  Linear.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class Linear: Easing {
    
    /**
     Linear ease.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    open class func ease(t: Double, b: Double, c: Double, d: Double) -> Double {
        return c * t / d + b
    }
}
