//
//  Math.swift
//  Ubergang
//
//  Created by RF on 15/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

class Math {
    class func zigZag(x: Double) -> Double {
        return 1 / M_PI * asin(cos(M_PI * (x + 1))) + 0.5
    }
}