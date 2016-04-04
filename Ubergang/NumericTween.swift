//
//  NumericTween.swift
//  Tween
//
//  Created by RF on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class NumericTween<T: Numeric>: UTween<T> {
    
    public convenience init() {
        let id = "\(__FILE__)_\(random() * 1000)_update"
        self.init(id: id)
    }
    
    public override init(id: String) {
        super.init(id: id)
    }
    
    public func ease(ease: Easing) {
        self.ease = ease
    }
    
    override func compute(value: Double) -> T {
        super.compute(value)
        
        let distance = to - from
        var parsedDistance: Double
        if distance is Double {
            parsedDistance = distance as! Double
        }
        else {
            parsedDistance = Double(distance)!
        }
        
        let total = T( parsedDistance * value )
        
        var currentValue = current()
        currentValue = from + total
        
        return currentValue
    }
}
