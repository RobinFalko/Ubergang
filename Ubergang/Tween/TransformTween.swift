//
//  TransformTween.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

open class TransformTween: UTween<CGAffineTransform> {
    override func compute(_ value: Double) -> CGAffineTransform {
        _ = super.compute(value)
        
        let from = self.fromC()
        let to = self.toC()
        
        var currentValue = CGAffineTransform.identity
        currentValue.tx = from.tx + (to.tx - from.tx) * CGFloat(value)
        currentValue.ty = from.ty + (to.ty - from.ty) * CGFloat(value)
        
        currentValue.a = from.a + (to.a - from.a) * CGFloat(value)
        currentValue.b = from.b + (to.b - from.b) * CGFloat(value)
        currentValue.c = from.c + (to.c - from.c) * CGFloat(value)
        currentValue.d = from.d + (to.d - from.d) * CGFloat(value)
        
        return currentValue
    }
}
