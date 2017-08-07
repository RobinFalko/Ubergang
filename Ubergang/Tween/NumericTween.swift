//
//  NumericTween.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class NumericTween<T: Numeric>: UTween<T> {
    override func compute(_ value: Double) -> T {
        _ = super.compute(value)
        
        let from = self.fromC()
        let to = self.toC()
        
        let distance = to - from
        var parsedDistance: Double
        if distance is Double {
            parsedDistance = distance as! Double
        }
        else {
            parsedDistance = Double(distance)!
        }
        
        let total = T( parsedDistance * value )
        
        return from + total
    }
}
