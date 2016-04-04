//
//  Ease.swift
//  Tween
//
//  Created by RF on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public typealias Easing = (t: Double, b: Double, c: Double, d: Double) -> Double

public class Ease {
    public class func linear(t t: Double, b: Double, c: Double, d: Double) -> Double {
        return c * t / d + b
    }
}
