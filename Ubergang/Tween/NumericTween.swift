//
//  NumericTween.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class NumericTween<T: Numeric>: UTween<T> {
    
    public convenience init() {
        let id = "\(#file)_\(arc4random())_update"
        self.init(id: id)
    }
    
    public override init(id: String) {
        super.init(id: id)
    }
    
    override func compute(_ value: Double) -> T {
        super.compute(value)
        
        let from = self.from()
        let to = self.to()
        
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
