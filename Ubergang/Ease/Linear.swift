//
//  Linear.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Linear: Ease {
    
    /**
     Linear ease.
     
     - Parameter t: The value to be mapped going from 0 to `d`
     - Parameter b: The mapped start value
     - Parameter c: The mapped end value
     - Parameter d: The end value
     - Returns: The mapped result
     */
    public class func ease(t t: Double, b: Double, c: Double, d: Double) -> Double {
        return c * t / d + b
    }
}