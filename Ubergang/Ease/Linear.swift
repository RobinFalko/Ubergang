//
//  Linear.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Linear: Ease {
    public class func ease(t t: Double, b: Double, c: Double, d: Double) -> Double {
        return c * t / d + b
    }
}