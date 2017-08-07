//
//  CGPointTween.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

open class CGPointTween: UTween<CGPoint> {
    
    var currentValue = CGPoint()
    
    override func compute(_ value: Double) -> CGPoint {
        _ = super.compute(value)
        
        let from = self.fromC()
        let to = self.toC()
        
        currentValue.x = from.x + (to.x - from.x) * CGFloat(value)
        currentValue.y = from.y + (to.y - from.y) * CGFloat(value)
        
        return currentValue
    }
}
