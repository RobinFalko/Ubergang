//
//  Computable.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit

public protocol Numeric {
    init()
    init(_ value: Int)
    init(_ value: Double)
    init(_ value: Float)
    
    func + (lhs: Self, rhs: Self) -> Self
    func - (lhs: Self, rhs: Self) -> Self
    func * (lhs: Self, rhs: Self) -> Self
    func / (lhs: Self, rhs: Self) -> Self
}

extension Double : Numeric {
    public init?<T: Numeric>(_ value: T) {
        switch (value) {
        case is Int:
            self.init(Double(value as! Int))
            break
        case is Int8:
            self.init(Double(value as! Int8))
            break
        case is Int16:
            self.init(Double(value as! Int16))
            break
        case is Int32:
            self.init(Double(value as! Int32))
            break
        case is Int64:
            self.init(Double(value as! Int64))
            break
        case is Float:
            self.init(Double(value as! Float))
            break
        case is CGFloat:
            self.init(Double(value as! CGFloat))
            break
        case is Double:
            fallthrough
        default:
            return nil
        }
    }
}
extension Float  : Numeric {}
extension Int    : Numeric {}
extension Int8   : Numeric {}
extension Int16  : Numeric {}
extension Int32  : Numeric {}
extension Int64  : Numeric {}
extension UInt   : Numeric {}
extension UInt8  : Numeric {}
extension UInt16 : Numeric {}
extension UInt32 : Numeric {}
extension UInt64 : Numeric {}
extension CGFloat: Numeric {}