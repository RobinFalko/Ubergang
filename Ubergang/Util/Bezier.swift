//
//  Bezier.swift
//  Ubergang
//
//  Created by RF on 17/05/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

class Bezier {
    static func interpolation(t t: CGFloat, a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat {
        let t2 = t * t
        let t3 = t2 * t
        return a + (-a * 3 + t * (3 * a - a * t)) * t
        + (3 * b + t * (-6 * b + b * 3 * t)) * t
        + (c * 3 - c * 3 * t) * t2
        + d * t3
    }
}